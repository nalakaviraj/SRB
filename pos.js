var global_brand_id = null;
var global_p_category_id = null;
var global_is_clear_local_storage = false;
var pos_payment_enter_step = 0;
var pos_payment_confirm_open = false;
var pos_payment_confirm_armed = false;
var pos_local_index = {
    key: null,
    items: [],
    exact_map: {},
    loaded: false,
    loading: false,
    last_updated: 0,
};
var pos_local_product_list_enabled = false;
var pos_local_index_ttl_ms = 20 * 60 * 1000;
var pos_local_index_max_results = 30;
var pos_idb_promise = null;
var pos_search_term = '';
var pos_search_timeout = null;
var pos_row_queue = [];
var pos_row_request_in_flight = false;
var pos_last_exact_sku = '';
var pos_last_exact_sku_at = 0;
var pos_suggestion_active = false;
var pos_suggestion_index = -1;
var pos_pending_suggestion_focus = false;

function pos_focus_search(select_text) {
    var $search = $('input#search_product');
    if (!$search.length || $search.is(':disabled')) {
        return;
    }
    $search.focus();
    if (select_text) {
        $search.select();
    }
}

function pos_clear_search_input() {
    var $search = $('input#search_product');
    if ($search.length) {
        $search.val('');
    }
}

function pos_clear_active_suggestion() {
    $('div#product_list_body .product_box').removeClass('active');
    pos_suggestion_active = false;
    pos_suggestion_index = -1;
    pos_pending_suggestion_focus = false;
}

function pos_get_suggestion_items() {
    return $('div#product_list_body .product_box');
}

function pos_get_suggestion_columns($items) {
    if (!$items.length) {
        return 1;
    }
    var $container = $('div#product_list_body');
    var itemWidth = $items.first().outerWidth(true) || 0;
    if (!itemWidth) {
        return 1;
    }
    var cols = Math.floor(($container.innerWidth() || itemWidth) / itemWidth);
    return Math.max(1, cols);
}

function pos_set_active_suggestion(index) {
    var $items = pos_get_suggestion_items();
    if (!$items.length) {
        pos_clear_active_suggestion();
        return false;
    }
    var count = $items.length;
    var nextIndex = index;
    if (nextIndex < 0) {
        nextIndex = count - 1;
    } else if (nextIndex >= count) {
        nextIndex = 0;
    }
    pos_suggestion_index = nextIndex;
    pos_suggestion_active = true;
    pos_pending_suggestion_focus = false;
    $items.removeClass('active');
    var $active = $items.eq(nextIndex).addClass('active');

    var $container = $('div#product_list_body');
    if ($container.length) {
        var itemTop = $active.position().top;
        var itemBottom = itemTop + $active.outerHeight();
        var viewTop = $container.scrollTop();
        var viewBottom = viewTop + $container.innerHeight();
        if (itemTop < viewTop) {
            $container.scrollTop(itemTop);
        } else if (itemBottom > viewBottom) {
            $container.scrollTop(itemBottom - $container.innerHeight());
        }
    }
    return true;
}

function pos_request_suggestion_focus() {
    pos_pending_suggestion_focus = true;
    var $items = pos_get_suggestion_items();
    if ($items.length) {
        pos_set_active_suggestion(0);
        return true;
    }
    return false;
}

function pos_focus_last_qty_with_retry(attempt) {
    var tries = attempt || 0;
    var $row = $('#pos_table tbody tr:last');
    if ($row.length) {
        var $qty = $row.find('input.pos_quantity');
        if ($qty.length) {
            $qty.focus().select();
            return;
        }
    }
    if (tries < 8) {
        setTimeout(function() {
            pos_focus_last_qty_with_retry(tries + 1);
        }, 120);
    }
}

function pos_is_modal_open() {
    return $('.modal.in:visible').length > 0 || $('.modal.show:visible').length > 0;
}

$(document).on('keydown', function(e) {
    if (e.which !== 32) {
        return;
    }
    if (pos_is_modal_open()) {
        return;
    }
    var $target = $(e.target);
    if ($target.is('input, textarea, select') || $target.is('[contenteditable="true"]')) {
        return;
    }
    if ($('#pos_table tbody tr').length > 0) {
        e.preventDefault();
        $('#pos-finalize').first().trigger('click');
    }
});

function pos_mark_active_row($row, flash) {
    if (!$row || !$row.length) {
        return;
    }
    $('#pos_table tbody tr').removeClass('pos-active-row');
    $row.addClass('pos-active-row');
    if (flash) {
        $row.addClass('pos-last-added');
        setTimeout(function() {
            $row.removeClass('pos-last-added');
        }, 1500);
    }
}

function pos_get_active_row() {
    var $active = $('#pos_table tbody tr.pos-active-row:last');
    if ($active.length) {
        return $active;
    }
    return $('#pos_table tbody tr:last');
}

function pos_adjust_quantity(delta) {
    var $row = pos_get_active_row();
    if (!$row.length) {
        return;
    }
    var $qty = $row.find('input.pos_quantity');
    if (!$qty.length) {
        return;
    }
    var qty = __read_number($qty);
    var new_qty = qty + delta;
    if (new_qty < 1) {
        new_qty = 1;
    }
    __write_number($qty, new_qty);
    $qty.trigger('change');
    pos_mark_active_row($row, true);
}

function pos_get_price_group() {
    if ($('#price_group').length > 0) {
        return $('#price_group').val() || '';
    }
    return '';
}

function pos_get_index_key() {
    var location_id = $('input#location_id').val() || '0';
    var price_group = pos_get_price_group();
    return 'pos_index_' + location_id + '_' + price_group;
}

function pos_get_index_invalidate_at() {
    if (typeof localStorage === 'undefined') {
        return 0;
    }
    var raw = localStorage.getItem('pos_index_invalidate_at');
    var ts = parseInt(raw, 10);
    return isNaN(ts) ? 0 : ts;
}

function pos_prepare_index(items) {
    var exact_map = {};
    items.forEach(function(item) {
        item.__lc_name = (item.name || '').toString().toLowerCase();
        item.__lc_variation = (item.variation || '').toString().toLowerCase();
        item.__lc_sku = (item.sku || '').toString().toLowerCase();
        item.__lc_sub_sku = (item.sub_sku || '').toString().toLowerCase();
        item.__lc_lot = (item.lot_number || '').toString().toLowerCase();
        item.__lc_custom1 = (item.product_custom_field1 || '').toString().toLowerCase();
        item.__lc_custom2 = (item.product_custom_field2 || '').toString().toLowerCase();
        item.__lc_custom3 = (item.product_custom_field3 || '').toString().toLowerCase();
        item.__lc_custom4 = (item.product_custom_field4 || '').toString().toLowerCase();
        if (item.__lc_sub_sku) {
            exact_map[item.__lc_sub_sku] = item;
        }
        if (item.__lc_sku) {
            exact_map[item.__lc_sku] = item;
        }
    });
    pos_local_index.items = items;
    pos_local_index.exact_map = exact_map;
}

function pos_idb_open() {
    if (!window.indexedDB) {
        return Promise.resolve(null);
    }
    if (pos_idb_promise) {
        return pos_idb_promise;
    }
    pos_idb_promise = new Promise(function(resolve, reject) {
        var request = indexedDB.open('pos_product_index', 1);
        request.onupgradeneeded = function(event) {
            var db = event.target.result;
            if (!db.objectStoreNames.contains('products')) {
                db.createObjectStore('products', { keyPath: 'key' });
            }
        };
        request.onsuccess = function(event) {
            resolve(event.target.result);
        };
        request.onerror = function() {
            resolve(null);
        };
    });
    return pos_idb_promise;
}

function pos_idb_get(key) {
    return pos_idb_open().then(function(db) {
        if (!db) {
            return pos_localstorage_get(key);
        }
        return new Promise(function(resolve) {
            var tx = db.transaction(['products'], 'readonly');
            var store = tx.objectStore('products');
            var req = store.get(key);
            req.onsuccess = function() {
                resolve(req.result || null);
            };
            req.onerror = function() {
                resolve(pos_localstorage_get(key));
            };
        });
    });
}

function pos_idb_set(key, data) {
    return pos_idb_open().then(function(db) {
        if (!db) {
            pos_localstorage_set(key, data);
            return;
        }
        var tx = db.transaction(['products'], 'readwrite');
        var store = tx.objectStore('products');
        store.put({ key: key, updated_at: Date.now(), items: data });
    });
}

function pos_localstorage_get(key) {
    try {
        var raw = localStorage.getItem(key);
        if (!raw) {
            return null;
        }
        return JSON.parse(raw);
    } catch (e) {
        return null;
    }
}

function pos_localstorage_set(key, data) {
    try {
        localStorage.setItem(key, JSON.stringify({ updated_at: Date.now(), items: data }));
    } catch (e) {
        // ignore quota errors
    }
}

function pos_get_search_fields() {
    var search_fields = [];
    $('.search_fields:checked').each(function(i) {
        search_fields[i] = $(this).val();
    });
    if (search_fields.indexOf('sku') !== -1 && search_fields.indexOf('sub_sku') === -1) {
        search_fields.push('sub_sku');
    }
    return search_fields;
}

function pos_local_search(term, search_fields) {
    if (!pos_local_index.loaded || !pos_local_index.items.length) {
        return null;
    }
    var t = (term || '').toString().trim().toLowerCase();
    if (!t) {
        return [];
    }
    if (pos_local_index.exact_map[t]) {
        return [pos_local_index.exact_map[t]];
    }
    var results_exact = [];
    var results_partial = [];
    var include_name = search_fields.indexOf('name') !== -1;
    var include_sku = search_fields.indexOf('sku') !== -1 || search_fields.indexOf('sub_sku') !== -1;
    var include_lot = search_fields.indexOf('lot') !== -1;
    var include_custom1 = search_fields.indexOf('product_custom_field1') !== -1;
    var include_custom2 = search_fields.indexOf('product_custom_field2') !== -1;
    var include_custom3 = search_fields.indexOf('product_custom_field3') !== -1;
    var include_custom4 = search_fields.indexOf('product_custom_field4') !== -1;

    for (var i = 0; i < pos_local_index.items.length; i++) {
        var item = pos_local_index.items[i];
        var match = false;
        var exact = false;
        if (include_name) {
            if (item.__lc_name === t || item.__lc_variation === t) {
                exact = true;
                match = true;
            } else if (item.__lc_name.indexOf(t) !== -1 || item.__lc_variation.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_sku) {
            if (item.__lc_sub_sku === t || item.__lc_sku === t) {
                exact = true;
                match = true;
            } else if (item.__lc_sub_sku.indexOf(t) !== -1 || item.__lc_sku.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_lot) {
            if (item.__lc_lot === t) {
                exact = true;
                match = true;
            } else if (item.__lc_lot.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_custom1) {
            if (item.__lc_custom1 === t) {
                exact = true;
                match = true;
            } else if (item.__lc_custom1.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_custom2) {
            if (item.__lc_custom2 === t) {
                exact = true;
                match = true;
            } else if (item.__lc_custom2.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_custom3) {
            if (item.__lc_custom3 === t) {
                exact = true;
                match = true;
            } else if (item.__lc_custom3.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (!match && include_custom4) {
            if (item.__lc_custom4 === t) {
                exact = true;
                match = true;
            } else if (item.__lc_custom4.indexOf(t) !== -1) {
                match = true;
            }
        }
        if (match) {
            if (exact) {
                results_exact.push(item);
            } else {
                results_partial.push(item);
            }
        }
    }
    var sorter = function(a, b) {
        var aq = a.qty_available || 0;
        var bq = b.qty_available || 0;
        return bq - aq;
    };
    results_exact.sort(sorter);
    results_partial.sort(sorter);
    return results_exact.concat(results_partial).slice(0, pos_local_index_max_results);
}

function pos_should_use_local_product_list() {
    return pos_local_product_list_enabled && pos_local_index.loaded && pos_local_index.items.length > 0;
}

function pos_parse_int(value) {
    if (value === null || typeof value === 'undefined' || value === '') {
        return null;
    }
    var parsed = parseInt(value, 10);
    return isNaN(parsed) ? null : parsed;
}

function pos_local_matches_term(item, term, search_fields) {
    if (!term) {
        return true;
    }
    var t = term.toString().trim().toLowerCase();
    if (!t) {
        return true;
    }
    if (search_fields.indexOf('name') !== -1 && item.__lc_name && item.__lc_name.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('sku') !== -1 && item.__lc_sku && item.__lc_sku.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('sub_sku') !== -1 && item.__lc_sub_sku && item.__lc_sub_sku.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('lot') !== -1 && item.__lc_lot && item.__lc_lot.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('product_custom_field1') !== -1 && item.__lc_custom1 && item.__lc_custom1.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('product_custom_field2') !== -1 && item.__lc_custom2 && item.__lc_custom2.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('product_custom_field3') !== -1 && item.__lc_custom3 && item.__lc_custom3.indexOf(t) !== -1) {
        return true;
    }
    if (search_fields.indexOf('product_custom_field4') !== -1 && item.__lc_custom4 && item.__lc_custom4.indexOf(t) !== -1) {
        return true;
    }
    if (item.__lc_variation && item.__lc_variation.indexOf(t) !== -1) {
        return true;
    }
    return false;
}

function pos_local_product_matches_filters(item, filters) {
    if (!item) {
        return false;
    }

    if (filters.category_id !== null) {
        if (item.category_id != filters.category_id && item.sub_category_id != filters.category_id) {
            return false;
        }
    }

    if (filters.brand_id !== null && item.brand_id != filters.brand_id) {
        return false;
    }

    if (filters.repair_model_id !== null && item.repair_model_id != filters.repair_model_id) {
        return false;
    }

    if (filters.is_enabled_stock !== null) {
        var needs_stock = filters.is_enabled_stock === 1;
        if ((item.enable_stock == 1) !== needs_stock) {
            return false;
        }
    }

    return pos_local_matches_term(item, filters.term, filters.search_fields);
}

function pos_get_local_product_image(item) {
    if (item && item.product_image) {
        return '/uploads/img/' + encodeURIComponent(item.product_image);
    }
    return '/img/default.png';
}

function pos_build_local_product_html(item) {
    var variation_text = '';
    if (item.type === 'variable' && item.variation) {
        variation_text = ' - ' + item.variation;
    }
    var sku_text = item.sub_sku ? '(' + item.sub_sku + ')' : '';
    var qty_text = '--';
    if (item.enable_stock == 1) {
        var qty_available = item.qty_available === null || typeof item.qty_available === 'undefined' ? 0 : item.qty_available;
        qty_text = __currency_trans_from_en(qty_available, false, false, __currency_precision, true);
        if (item.unit) {
            qty_text += ' ' + item.unit;
        }
    }
    var title = (item.name || '') + variation_text + (sku_text ? ' ' + sku_text : '');
    var image_url = pos_get_local_product_image(item);

    var edit_btn = '';
    if (window.__pos_can_edit_product) {
        edit_btn = '<button type="button" class="pos-product-edit-btn" data-product_id="' + item.product_id + '" title="Edit">' +
            '<i class="fa fa-edit"></i>' +
            '</button>';
    }

    return '' +
        '<div class="col-md-3 col-xs-4 product_list no-print">' +
            '<div class="product_box hover:tw-shadow-lg hover:tw-animate-pulse" data-variation_id="' + item.variation_id + '" data-sub_sku="' + (item.sub_sku || '') + '" data-sku="' + (item.sku || '') + '" title="' + title + '">' +
                edit_btn +
                '<div class="image-container" style="background-image: url(' + image_url + '); background-repeat: no-repeat; background-position: center; background-size: contain;"></div>' +
                '<div class="text_div">' +
                    '<small class="text text-muted">' + (item.name || '') + variation_text + '</small>' +
                    (sku_text ? '<small class="text-muted"> ' + sku_text + '</small><br>' : '<br>') +
                    '<small class="text-muted" style="font-size: 60%;">' + qty_text + '</small>' +
                '</div>' +
            '</div>' +
        '</div>';
}

function pos_try_add_exact_from_suggestion(term) {
    var t = (term || '').toString().trim().toLowerCase();
    if (!t) {
        return false;
    }
    var now = Date.now();
    if (pos_last_exact_sku === t && now - pos_last_exact_sku_at < 800) {
        return true;
    }
    var $match = $('div#product_list_body .product_box').filter(function() {
        var sku = ($(this).data('sku') || '').toString().toLowerCase();
        var subSku = ($(this).data('sub_sku') || '').toString().toLowerCase();
        return sku === t || subSku === t;
    }).first();

    if ($match.length) {
        var variation_id = $match.data('variation_id');
        if (variation_id !== null && typeof variation_id !== 'undefined') {
            $('input#search_product').val(null);
            pos_search_term = '';
            $('input#suggestion_page').val(1);
            pos_last_exact_sku = t;
            pos_last_exact_sku_at = now;
            pos_pending_suggestion_focus = false;
            pos_product_row(variation_id);
            $('div#product_list_body').html('');
            return true;
        }
    }
    return false;
}

function pos_update_local_index_item(updated) {
    if (!updated || !pos_local_index.items || !pos_local_index.items.length) {
        return;
    }
    var target_id = parseInt(updated.variation_id || 0, 10);
    if (!target_id) {
        return;
    }
    var found = false;
    pos_local_index.items.forEach(function(item) {
        if (parseInt(item.variation_id, 10) === target_id) {
            item.name = updated.name || item.name;
            item.sku = updated.sku || item.sku;
            item.sub_sku = updated.sub_sku || item.sub_sku;
            item.type = updated.type || item.type;
            if (typeof updated.enable_stock !== 'undefined') {
                item.enable_stock = updated.enable_stock;
            }
            if (typeof updated.selling_price !== 'undefined') {
                item.selling_price = updated.selling_price;
            }
            if (typeof updated.qty_available !== 'undefined') {
                item.qty_available = updated.qty_available;
            }
            if (typeof updated.unit !== 'undefined') {
                item.unit = updated.unit;
            }
            if (typeof updated.product_image !== 'undefined') {
                item.product_image = updated.product_image;
            }
            found = true;
        }
    });
    if (found) {
        pos_prepare_index(pos_local_index.items);
        pos_idb_set(pos_get_index_key(), pos_local_index.items);
    }
}

function pos_update_cart_stock(variation_id, qty_available, unit) {
    if (!variation_id && variation_id !== 0) {
        return;
    }
    var qty_num = qty_available;
    if (qty_num === null || typeof qty_num === 'undefined') {
        return;
    }
    var formatted_qty = __currency_trans_from_en(qty_num, false, false, __currency_precision, true);
    var label = formatted_qty + (unit ? ' ' + unit : '') + ' in stock';
    $('input.row_variation_id[value="' + variation_id + '"]').each(function() {
        var $row = $(this).closest('tr');
        var $stock = $row.find('small.text-muted.p-1');
        if ($stock.length) {
            $stock.text(label.trim());
        }
    });
}

function pos_render_local_product_list(filters, page) {
    var $list = $('div#product_list_body');
    if (!$list.length) {
        return;
    }
    var term = filters && filters.term ? filters.term.toString().trim().toLowerCase() : '';
    if (term && pos_local_index.exact_map && pos_local_index.exact_map[term]) {
        var now = Date.now();
        if (!(pos_last_exact_sku === term && now - pos_last_exact_sku_at < 800)) {
            var exact_item = pos_local_index.exact_map[term];
            var is_overselling_allowed = false;
            if ($('input#is_overselling_allowed').length) {
                is_overselling_allowed = true;
            }
            var for_so = false;
            if ($('#sale_type').length && $('#sale_type').val() == 'sales_order') {
                for_so = true;
            }
            var is_draft = false;
            if ($('#status') && ($('#status').val() == 'quotation' || $('#status').val() == 'draft')) {
                is_draft = true;
            }

            if (
                exact_item.enable_stock != 1 ||
                exact_item.qty_available > 0 ||
                is_overselling_allowed ||
                for_so ||
                is_draft
            ) {
                $('input#search_product').val(null);
                pos_search_term = '';
                $('input#suggestion_page').val(1);
                pos_last_exact_sku = term;
                pos_last_exact_sku_at = now;
                pos_product_row(exact_item.variation_id);
            } else {
                toastr.error(LANG.out_of_stock);
                pos_focus_search(true);
            }
        }
        $list.html('');
        return;
    }
    var per_page = 50;
    var page_num = page || 1;
    var all_items = pos_local_index.items.filter(function(item) {
        return pos_local_product_matches_filters(item, filters);
    });
    all_items.sort(function(a, b) {
        var an = (a.name || '').toString().toLowerCase();
        var bn = (b.name || '').toString().toLowerCase();
        if (an < bn) {
            return -1;
        }
        if (an > bn) {
            return 1;
        }
        return 0;
    });

    var start = (page_num - 1) * per_page;
    var end = start + per_page;
    var slice = all_items.slice(start, end);

    if (page_num === 1) {
        $list.html('');
    }

    if (!slice.length) {
        if (page_num === 1) {
            var empty_text = (typeof LANG !== 'undefined' && LANG.no_products_found) ? LANG.no_products_found : 'No products to display';
            $list.html('<input type="hidden" id="no_products_found"><div class="col-md-12"><h4 class="text-center">' + empty_text + '</h4></div>');
        }
        return;
    }

    var html = '';
    slice.forEach(function(item) {
        html += pos_build_local_product_html(item);
    });
    $list.append(html);
    pos_try_add_exact_from_suggestion(filters.term);
    if (pos_pending_suggestion_focus) {
        pos_set_active_suggestion(0);
    }
}

function pos_load_local_index(force_refresh) {
    var key = pos_get_index_key();
    var invalidate_at = pos_get_index_invalidate_at();
    if (invalidate_at && pos_local_index.last_updated && pos_local_index.last_updated < invalidate_at) {
        force_refresh = true;
    }
    if (!force_refresh && pos_local_index.loaded && pos_local_index.key === key) {
        return;
    }
    pos_local_index.key = key;
    pos_local_index.loading = true;

    pos_idb_get(key).then(function(cached) {
        var now = Date.now();
        if (cached && cached.items && cached.items.length) {
            pos_prepare_index(cached.items);
            pos_local_index.loaded = true;
            pos_local_index.last_updated = cached.updated_at || 0;
        }
        var is_stale = !cached || !cached.updated_at || (now - cached.updated_at) > pos_local_index_ttl_ms;
        if (invalidate_at && (!cached || !cached.updated_at || cached.updated_at < invalidate_at)) {
            is_stale = true;
        }
        if (!force_refresh && !is_stale) {
            pos_local_index.loading = false;
            return;
        }
        if (!navigator.onLine) {
            pos_local_index.loading = false;
            return;
        }
        var price_group = pos_get_price_group();
        var search_fields = pos_get_search_fields();
        $.getJSON('/products/list', {
            location_id: $('input#location_id').val(),
            price_group: price_group,
            not_for_selling: 0,
            term: '',
            search_fields: search_fields,
            pos_index: 1
        }).done(function(data) {
            if (data && data.length) {
                pos_prepare_index(data);
                pos_local_index.loaded = true;
                pos_local_index.last_updated = Date.now();
                pos_idb_set(key, data);
            }
        }).always(function() {
            pos_local_index.loading = false;
        });
    });
}
if (typeof window !== 'undefined' && window.addEventListener) {
    window.addEventListener('storage', function(e) {
        if (e.key === 'pos_index_invalidate_at') {
            pos_load_local_index(true);
        }
    });
}
$(document).ready(function() {
    customer_set = false;
    //Prevent enter key function except texarea
    $('form').on('keyup keypress', function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode === 13 && e.target.tagName != 'TEXTAREA') {
            e.preventDefault();
            return false;
        }
    });

    //For edit pos form
    if ($('form#edit_pos_sell_form').length > 0) {
        pos_total_row();
        pos_form_obj = $('form#edit_pos_sell_form');
    } else {
        pos_form_obj = $('form#add_pos_sell_form');
    }
    if ($('form#edit_pos_sell_form').length > 0 || $('form#add_pos_sell_form').length > 0) {
        initialize_printer();
    }

    // Keep cashier flow fast: focus search when idle
    setTimeout(function() {
        pos_focus_search(true);
    }, 300);
    $(document).on('hidden.bs.modal', '.modal', function() {
        pos_focus_search(true);
    });

    // Track active row for quick quantity edits
    $('#pos_table').on('click', 'tbody tr', function() {
        pos_mark_active_row($(this), false);
    });
    $('#pos_table').on('focus', 'input.pos_quantity', function() {
        pos_mark_active_row($(this).closest('tr'), false);
    });

    // Quick quantity adjust from keyboard
    $(document).on('keydown', function(e) {
        if (pos_is_modal_open()) {
            return;
        }
        var $target = $(e.target);
        if ($target.is('input, textarea, select') || $target.hasClass('select2-search__field')) {
            // Allow +/- from search field when empty
            if (!$target.is('#search_product')) {
                return;
            }
            if ($target.val() && $target.val().trim() !== '') {
                return;
            }
        }

        var key = e.which;
        if (key === 187 || key === 107) { // + / numpad +
            e.preventDefault();
            pos_adjust_quantity(1);
            pos_focus_search(true);
        } else if (key === 189 || key === 109) { // - / numpad -
            e.preventDefault();
            pos_adjust_quantity(-1);
            pos_focus_search(true);
        } else if (!$target.is('input, textarea, select')) {
            // If user starts typing anywhere, route to search
            if ((key >= 48 && key <= 90) || (key >= 96 && key <= 105)) {
                pos_focus_search(false);
            }
        }
    });

    // If cart is empty, pressing Enter should always return focus to search
    $(document).on('keydown', function(e) {
        if (e.which !== 13) {
            return;
        }
        if (pos_is_modal_open()) {
            return;
        }
        if ($('#pos_table tbody tr').length > 0) {
            return;
        }
        // Don't hijack selection in open dropdowns/autocomplete
        if ($('.select2-container--open').length) {
            return;
        }
        if ($(e.target).is('#search_product') && $('.ui-autocomplete:visible').length) {
            return;
        }
        e.preventDefault();
        pos_focus_search(true);
    });

    $('select#select_location_id').change(function() {
        reset_pos_form();

        var default_price_group = $(this).find(':selected').data('default_price_group')
        if (default_price_group) {
            if($("#price_group option[value='" + default_price_group + "']").length > 0) {
                $("#price_group").val(default_price_group);
                $("#price_group").change();
            }
        }

        //Set default invoice scheme for location
        if ($('#invoice_scheme_id').length) {
            if($('input[name="is_direct_sale"]').length > 0){
                //default scheme for sale screen
                var invoice_scheme_id = $(this).find(':selected').data('default_sale_invoice_scheme_id');
            } else {
                var invoice_scheme_id =  $(this).find(':selected').data('default_invoice_scheme_id');
            }
            
            $("#invoice_scheme_id").val(invoice_scheme_id).change();
        }

        //Set default invoice layout for location
        if ($('#invoice_layout_id').length) {
            let invoice_layout_id = $(this).find(':selected').data('default_invoice_layout_id');
            $("#invoice_layout_id").val(invoice_layout_id).change();
        }
        
        //Set default price group
        if ($('#default_price_group').length) {
            var dpg = default_price_group ?
            default_price_group : 0;
            $('#default_price_group').val(dpg);
        }

        set_payment_type_dropdown();

        if ($('#types_of_service_id').length && $('#types_of_service_id').val()) {
            $('#types_of_service_id').change();
        }
        setTimeout(function() {
            pos_load_local_index(true);
        }, 100);
    });

    //get customer
    $('select#customer_id').select2({
        ajax: {
            url: '/contacts/customers',
            dataType: 'json',
            delay: 250,
            data: function(params) {
                return {
                    q: params.term, // search term
                    page: params.page,
                };
            },
            processResults: function(data) {
                return {
                    results: data,
                };
            },
        },
        templateResult: function (data) { 
            var template = '';
            if (data.supplier_business_name) {
                template += data.supplier_business_name + "<br>";
            }
            template += data.text + "<br>" + LANG.mobile + ": " + data.mobile;

            if (typeof(data.total_rp) != "undefined") {
                var rp = data.total_rp ? data.total_rp : 0;
                template += "<br><i class='fa fa-gift text-success'></i> " + rp;
            }

            return  template;
        },
        minimumInputLength: 1,
        language: {
            inputTooShort: function (args) {
                return LANG.please_enter + args.minimum + LANG.or_more_characters;
            },
            noResults: function() {
                var name = $('#customer_id')
                    .data('select2')
                    .dropdown.$search.val();
                return (
                    '<button type="button" data-name="' +
                    name +
                    '" class="btn btn-link add_new_customer"><i class="fa fa-plus-circle fa-lg" aria-hidden="true"></i>&nbsp; ' +
                    __translate('add_name_as_new_customer', { name: name }) +
                    '</button>'
                );
            },
        },
        escapeMarkup: function(markup) {
            return markup;
        },
    });
    $('#customer_id').on('select2:select', function(e) {
        var data = e.params.data;
        if (data.pay_term_number) {
            $('input#pay_term_number').val(data.pay_term_number);
        } else {
            $('input#pay_term_number').val('');
        }

        if (data.pay_term_type) {
            $('#add_sell_form select[name="pay_term_type"]').val(data.pay_term_type);
            $('#edit_sell_form select[name="pay_term_type"]').val(data.pay_term_type);
        } else {
            $('#add_sell_form select[name="pay_term_type"]').val('');
            $('#edit_sell_form select[name="pay_term_type"]').val('');
        }
        
        update_shipping_address(data);
        $('#advance_balance_text').text(__currency_trans_from_en(data.balance), true);
        $('#advance_balance').val(data.balance);

        if (data.price_calculation_type == 'selling_price_group') {
            $('#price_group').val(data.selling_price_group_id);
            $('#price_group').change();
        }
        //  else {
        //     $('#price_group').val(0);
        //     $('#price_group').change();
        // }
        if ($('.contact_due_text').length) {
            get_contact_due(data.id);
            // store on customer change
            saveFormDataToLocalStorage();
        }
    });

    set_default_customer();

    if ($('#search_product').length) {
        //Add Product
        $('#search_product')
            .autocomplete({
                delay: 200,
                source: function(request, response) {
                    var price_group = pos_get_price_group();
                    var search_fields = pos_get_search_fields();
                    if (!pos_local_product_list_enabled) {
                        $.getJSON('/products/list', {
                            location_id: $('input#location_id').val(),
                            price_group: price_group,
                            not_for_selling: 0,
                            term: request.term,
                            search_fields: search_fields,
                            pos_index: 1
                        }).done(function(data) {
                            response(data || []);
                        }).fail(function() {
                            response([]);
                        });
                        return;
                    }
                    var invalidate_at = pos_get_index_invalidate_at();
                    if (invalidate_at && (!pos_local_index.last_updated || pos_local_index.last_updated < invalidate_at)) {
                        if (!pos_local_index.loading) {
                            pos_load_local_index(true);
                        }
                        $.getJSON('/products/list', {
                            location_id: $('input#location_id').val(),
                            price_group: price_group,
                            not_for_selling: 0,
                            term: request.term,
                            search_fields: search_fields,
                            pos_index: 1
                        }).done(function(data) {
                            response(data || []);
                        }).fail(function() {
                            response([]);
                        });
                        return;
                    }
                    var local_results = pos_local_search(request.term, search_fields);
                    if (local_results && local_results.length) {
                        response(local_results);
                        return;
                    }
                    if (!pos_local_index.loaded && !pos_local_index.loading) {
                        pos_load_local_index(false);
                    }
                    response([]);
                    return;
                },
                minLength: 2,
                open: function() {
                    $(this).autocomplete('widget').hide();
                },
                response: function(event, ui) {
                    if (ui.content.length == 1) {
                        ui.item = ui.content[0];

                        var is_overselling_allowed = false;
                        if($('input#is_overselling_allowed').length) {
                            is_overselling_allowed = true;
                        }
                        var for_so = false;
                        if ($('#sale_type').length && $('#sale_type').val() == 'sales_order') {
                            for_so = true;
                        }

                        if ((ui.item.enable_stock == 1 && ui.item.qty_available > 0) || 
                                (ui.item.enable_stock == 0) || is_overselling_allowed || for_so) {
                            $(this)
                                .data('ui-autocomplete')
                                ._trigger('select', 'autocompleteselect', ui);
                            $(this).autocomplete('close');
                        }
                    } else if (ui.content.length == 0) {
                        toastr.error(LANG.no_products_found);
                        if (!$('#__is_mobile').length) {
                            $('input#search_product').select();
                        }
                    }
                },
                focus: function(event, ui) {
                    if (ui.item.qty_available <= 0) {
                        return false;
                    }
                },
                select: function(event, ui) {
                    var searched_term = $(this).val();
                    var is_overselling_allowed = false;
                    if($('input#is_overselling_allowed').length) {
                        is_overselling_allowed = true;
                    }
                    var for_so = false;
                    if ($('#sale_type').length && $('#sale_type').val() == 'sales_order') {
                        for_so = true;
                    }

                    var is_draft=false;
                    if($('#status') && ($('#status').val()=='quotation' || 
                    $('#status').val()=='draft')) {
                        var is_draft=true;
                    }

                    if (ui.item.enable_stock != 1 || ui.item.qty_available > 0 || is_overselling_allowed || for_so || is_draft) {
                        $(this).val(null);

                        //Pre select lot number only if the searched term is same as the lot number
                        var purchase_line_id = ui.item.purchase_line_id && searched_term == ui.item.lot_number ? ui.item.purchase_line_id : null;
                        pos_product_row(ui.item.variation_id, purchase_line_id);
                    } else {
                        toastr.error(LANG.out_of_stock);
                        pos_focus_search(true);
                    }
                },
            })
            .autocomplete('instance')._renderItem = function(ul, item) {
                var is_overselling_allowed = false;
                if($('input#is_overselling_allowed').length) {
                    is_overselling_allowed = true;
                }

                var for_so = false;
                if ($('#sale_type').length && $('#sale_type').val() == 'sales_order') {
                    for_so = true;
                }
                var is_draft=false;
                
                if($('#status') && ($('#status').val()=='quotation' || 
                $('#status').val()=='draft')) {
                    var is_draft=true;
                }

            if (item.enable_stock == 1 && item.qty_available <= 0 && !is_overselling_allowed && !for_so && !is_draft) {
                var string = '<li class="ui-state-disabled">' + item.name;
                if (item.type == 'variable') {
                    string += '-' + item.variation;
                }
                var selling_price = item.selling_price;
                if (item.variation_group_price) {
                    selling_price = item.variation_group_price;
                }
                string +=
                    ' (' +
                    item.sub_sku +
                    ')' +
                    '<br> Price: ' +
                    __currency_trans_from_en(selling_price, false, false, __currency_precision, true) +
                    ' (Out of stock) </li>';
                return $(string).appendTo(ul);
            } else {
                var string = '<div>' + item.name;
                if (item.type == 'variable') {
                    string += '-' + item.variation;
                }

                var selling_price = item.selling_price;
                if (item.variation_group_price) {
                    selling_price = item.variation_group_price;
                }

                string += ' (' + item.sub_sku + ')' + '<br> Price: ' + __currency_trans_from_en(selling_price, false, false, __currency_precision, true);
                if (item.enable_stock == 1) {
                    var qty_available = __currency_trans_from_en(item.qty_available, false, false, __currency_precision, true);
                    string += ' - ' + qty_available + item.unit;
                }
                string += '</div>';

                return $('<li>')
                    .append(string)
                    .appendTo(ul);
            }
        };
        $('#search_product').on('input', function() {
            var location_id = $('input#location_id').val();
            if (!location_id) {
                return;
            }
            var term = $(this).val().trim();
            clearTimeout(pos_search_timeout);
            pos_search_timeout = setTimeout(function() {
                var term_lc = term.toLowerCase();
                var exact_item =
                    pos_local_index.loaded &&
                    pos_local_index.exact_map &&
                    pos_local_index.exact_map[term_lc]
                        ? pos_local_index.exact_map[term_lc]
                        : null;
                if (exact_item) {
                    var is_overselling_allowed = false;
                    if ($('input#is_overselling_allowed').length) {
                        is_overselling_allowed = true;
                    }
                    var for_so = false;
                    if ($('#sale_type').length && $('#sale_type').val() == 'sales_order') {
                        for_so = true;
                    }
                    var is_draft = false;
                    if ($('#status') && ($('#status').val() == 'quotation' || $('#status').val() == 'draft')) {
                        is_draft = true;
                    }

                    if (
                        exact_item.enable_stock != 1 ||
                        exact_item.qty_available > 0 ||
                        is_overselling_allowed ||
                        for_so ||
                        is_draft
                    ) {
                        $('input#search_product').val(null);
                        pos_search_term = '';
                        $('input#suggestion_page').val(1);
                        pos_last_exact_sku = term_lc;
                        pos_last_exact_sku_at = Date.now();
                        pos_product_row(exact_item.variation_id);
                    } else {
                        toastr.error(LANG.out_of_stock);
                        pos_focus_search(true);
                    }
                    return;
                }

                pos_search_term = term.length >= 2 ? term : '';
                $('input#suggestion_page').val(1);

                var is_enabled_stock = null;
                if ($("#is_enabled_stock").length) {
                    is_enabled_stock = $("#is_enabled_stock").val();
                }

                var device_model_id = null;
                if ($("#repair_model_id").length) {
                    device_model_id = $("#repair_model_id").val();
                }

                get_product_suggestion_list(
                    global_p_category_id,
                    global_brand_id,
                    location_id,
                    null,
                    is_enabled_stock,
                    device_model_id
                );
            }, 250);
        });
        setTimeout(function() {
            pos_load_local_index(false);
        }, 150);
        setInterval(function() {
            if (navigator.onLine && !pos_local_index.loading) {
                pos_load_local_index(true);
            }
        }, pos_local_index_ttl_ms);
    }

    //Update line total and check for quantity not greater than max quantity
    $('table#pos_table tbody').on('change', 'input.pos_quantity', function() {
        // comment line becouse it validate form at increment and decrement item
        // if (sell_form_validator) {
        //     sell_form.valid();
        // }
        if (pos_form_validator) {
            pos_form_validator.element($(this));
        }
        // var max_qty = parseFloat($(this).data('rule-max'));
        var entered_qty = __read_number($(this));

        var tr = $(this).parents('tr');

        var unit_price_inc_tax = __read_number(tr.find('input.pos_unit_price_inc_tax'));
        var line_total = entered_qty * unit_price_inc_tax;

        __write_number(tr.find('input.pos_line_total'), line_total, false);
        tr.find('span.pos_line_total_text').text(__currency_trans_from_en(line_total, true));

        //Change modifier quantity
        tr.find('.modifier_qty_text').each( function(){
            $(this).text(__currency_trans_from_en(entered_qty, false));
        });
        tr.find('.modifiers_quantity').each( function(){
            $(this).val(entered_qty);
        });

        pos_total_row();

        adjustComboQty(tr);
    });

    //If change in unit price update price including tax and line total
    $('table#pos_table tbody').on('change', 'input.pos_unit_price', function() {
        var unit_price = __read_number($(this));
        var tr = $(this).parents('tr');

        //calculate discounted unit price
        var discounted_unit_price = calculate_discounted_unit_price(tr);

        var tax_rate = tr
            .find('select.tax_id')
            .find(':selected')
            .data('rate');
        var quantity = __read_number(tr.find('input.pos_quantity'));

        var unit_price_inc_tax = __add_percent(discounted_unit_price, tax_rate);
        var line_total = quantity * unit_price_inc_tax;

        __write_number(tr.find('input.pos_unit_price_inc_tax'), unit_price_inc_tax);
        __write_number(tr.find('input.pos_line_total'), line_total);
        tr.find('span.pos_line_total_text').text(__currency_trans_from_en(line_total, true));
        pos_each_row(tr);
        pos_total_row();
        round_row_to_iraqi_dinnar(tr);
    });

    //If change in tax rate then update unit price according to it.
    $('table#pos_table tbody').on('change', 'select.tax_id', function() {
        var tr = $(this).parents('tr');

        var tax_rate = tr
            .find('select.tax_id')
            .find(':selected')
            .data('rate');
        var unit_price_inc_tax = __read_number(tr.find('input.pos_unit_price_inc_tax'));

        var discounted_unit_price = __get_principle(unit_price_inc_tax, tax_rate);
        var unit_price = get_unit_price_from_discounted_unit_price(tr, discounted_unit_price);
        __write_number(tr.find('input.pos_unit_price'), unit_price);
        pos_each_row(tr);
    });

    //If change in unit price including tax, update unit price
    $('table#pos_table tbody').on('change', 'input.pos_unit_price_inc_tax', function() {
        var unit_price_inc_tax = __read_number($(this));

        if (iraqi_selling_price_adjustment) {
            unit_price_inc_tax = round_to_iraqi_dinnar(unit_price_inc_tax);
            __write_number($(this), unit_price_inc_tax);
        }

        var tr = $(this).parents('tr');

        var tax_rate = tr
            .find('select.tax_id')
            .find(':selected')
            .data('rate');
        var quantity = __read_number(tr.find('input.pos_quantity'));

        var line_total = quantity * unit_price_inc_tax;
        var discounted_unit_price = __get_principle(unit_price_inc_tax, tax_rate);
        var unit_price = get_unit_price_from_discounted_unit_price(tr, discounted_unit_price);

        __write_number(tr.find('input.pos_unit_price'), unit_price);
        __write_number(tr.find('input.pos_line_total'), line_total, false);
        tr.find('span.pos_line_total_text').text(__currency_trans_from_en(line_total, true));

        pos_each_row(tr);
        pos_total_row();
    });

    //Change max quantity rule if lot number changes
    $('table#pos_table tbody').on('change', 'select.lot_number', function() {
        var qty_element = $(this)
            .closest('tr')
            .find('input.pos_quantity');

        var tr = $(this).closest('tr');
        var multiplier = 1;
        var unit_name = '';
        var sub_unit_length = tr.find('select.sub_unit').length;
        if (sub_unit_length > 0) {
            var select = tr.find('select.sub_unit');
            multiplier = parseFloat(select.find(':selected').data('multiplier'));
            unit_name = select.find(':selected').data('unit_name');
        }
        var allow_overselling = qty_element.data('allow-overselling');
        if ($(this).val() && !allow_overselling) {
            var lot_qty = $('option:selected', $(this)).data('qty_available');
            var max_err_msg = $('option:selected', $(this)).data('msg-max');

            if (sub_unit_length > 0) {
                lot_qty = lot_qty / multiplier;
                var lot_qty_formated = __number_f(lot_qty, false);
                max_err_msg = __translate('lot_max_qty_error', {
                    max_val: lot_qty_formated,
                    unit_name: unit_name,
                });
            }

            qty_element.attr('data-rule-max-value', lot_qty);
            qty_element.attr('data-msg-max-value', max_err_msg);

            qty_element.rules('add', {
                'max-value': lot_qty,
                messages: {
                    'max-value': max_err_msg,
                },
            });
        } else {
            var default_qty = qty_element.data('qty_available');
            var default_err_msg = qty_element.data('msg_max_default');
            if (sub_unit_length > 0) {
                default_qty = default_qty / multiplier;
                var lot_qty_formated = __number_f(default_qty, false);
                default_err_msg = __translate('pos_max_qty_error', {
                    max_val: lot_qty_formated,
                    unit_name: unit_name,
                });
            }

            qty_element.attr('data-rule-max-value', default_qty);
            qty_element.attr('data-msg-max-value', default_err_msg);

            qty_element.rules('add', {
                'max-value': default_qty,
                messages: {
                    'max-value': default_err_msg,
                },
            });
        }
        qty_element.trigger('change');
    });

    //Change in row discount type or discount amount
    $('table#pos_table tbody').on(
        'change',
        'select.row_discount_type, input.row_discount_amount',
        function() {
            var tr = $(this).parents('tr');

            //calculate discounted unit price
            var discounted_unit_price = calculate_discounted_unit_price(tr);

            var tax_rate = tr
                .find('select.tax_id')
                .find(':selected')
                .data('rate');
            var quantity = __read_number(tr.find('input.pos_quantity'));

            var unit_price_inc_tax = __add_percent(discounted_unit_price, tax_rate);
            var line_total = quantity * unit_price_inc_tax;

            __write_number(tr.find('input.pos_unit_price_inc_tax'), unit_price_inc_tax);
            __write_number(tr.find('input.pos_line_total'), line_total, false);
            tr.find('span.pos_line_total_text').text(__currency_trans_from_en(line_total, true));
            pos_each_row(tr);
            pos_total_row();
            round_row_to_iraqi_dinnar(tr);
        }
    );

    //Remove row on click on remove row
    $('table#pos_table tbody').on('click', 'i.pos_remove_row', function() {
        $(this)
            .parents('tr')
            .remove();
        pos_total_row();
    });

    //Cancel the invoice
    $('button#pos-cancel').click(function() {
        swal({
            title: LANG.sure,
            icon: 'warning',
            buttons: true,
            dangerMode: true,
        }).then(confirm => {
            if (confirm) {
                reset_pos_form();
            }
        });
    });

    //Save invoice as draft
    $('button#pos-draft').click(function() {
        //Check if product is present or not.
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }

        var is_valid = isValidPosForm();
        if (is_valid != true) {
            return;
        }

        var data = pos_form_obj.serialize();
        data = data + '&status=draft';
        var url = pos_form_obj.attr('action');

        disable_pos_form_actions();
        $.ajax({
            method: 'POST',
            url: url,
            data: data,
            dataType: 'json',
            success: function(result) {
                enable_pos_form_actions();
                if (result.success == 1) {
                    reset_pos_form();
                    toastr.success(result.msg);
                } else {
                    toastr.error(result.msg);
                }
            },
        });
    });

    //Save invoice as Quotation
    $('button#pos-quotation').click(function() {
        //Check if product is present or not.
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }

        var is_valid = isValidPosForm();
        if (is_valid != true) {
            return;
        }

        var data = pos_form_obj.serialize();
        data = data + '&status=quotation';
        var url = pos_form_obj.attr('action');

        disable_pos_form_actions();
        $.ajax({
            method: 'POST',
            url: url,
            data: data,
            dataType: 'json',
            success: function(result) {
                enable_pos_form_actions();
                if (result.success == 1) {
                    reset_pos_form();
                    toastr.success(result.msg);

                    //Check if enabled or not
                    if (result.receipt.is_enabled) {
                        pos_print(result.receipt);
                    }
                } else {
                    toastr.error(result.msg);
                }
            },
        });
    });

    //Finalize invoice, open payment modal
    $('button#pos-finalize').click(function() {
        //Check if product is present or not.
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }
        if (pos_has_pending_rows()) {
            var msg = (typeof LANG !== 'undefined' && LANG.processing) ? LANG.processing : 'Adding products, please wait';
            toastr.warning(msg);
            return false;
        }

        if ($('#reward_point_enabled').length) {
            var validate_rp = isValidatRewardPoint();
            if (!validate_rp['is_valid']) {
                toastr.error(validate_rp['msg']);
                return false;
            }
        }

        $('#modal_payment').modal('show');
    });

    $('#modal_payment').on('shown.bs.modal', function() {
        pos_payment_enter_step = 0;
        focus_payment_amount_field();
        if ($('form#edit_pos_sell_form').length == 0) {
            $(this).find('#method_0').change();
        }
    });

    $('#modal_payment').on('hidden.bs.modal', function() {
        pos_payment_enter_step = 0;
    });

    function focus_payment_amount_field() {
        var amount_input = $('#modal_payment').find('input.payment-amount:visible:first');
        if (amount_input.length) {
            amount_input.focus().select();
        }
    }
    function is_swal_open() {
        return document.querySelector('.swal-overlay--show-modal') ||
            document.querySelector('.swal-modal') ||
            document.querySelector('.sweet-alert') ||
            document.querySelector('.swal2-popup');
    }
    function get_swal_confirm_button() {
        return document.querySelector('.swal-overlay--show-modal .swal-button--confirm') ||
            document.querySelector('.swal-modal .swal-button--confirm') ||
            document.querySelector('.sweet-alert .confirm') ||
            document.querySelector('.swal2-confirm');
    }
    function trigger_swal_confirm() {
        var confirmBtn = get_swal_confirm_button();
        if (confirmBtn) {
            confirmBtn.focus();
            confirmBtn.click();
            return true;
        }
        return false;
    }
    function focus_swal_confirm(attempts) {
        var tries = attempts || 12;
        var confirmBtn = get_swal_confirm_button();
        if (confirmBtn) {
            confirmBtn.focus();
            return;
        }
        if (tries > 0) {
            setTimeout(function() {
                focus_swal_confirm(tries - 1);
            }, 50);
        }
    }

    $('#modal_payment').on('keydown', function(e) {
        if (e.which !== 13) {
            return;
        }
        var $target = $(e.target);
        if ($target.is('textarea')) {
            return;
        }
        if ($target.hasClass('select2-search__field') || $target.closest('.select2-container').length) {
            return;
        }
        if ($target.is('#pos-save') || $target.closest('#pos-save').length) {
            return;
        }
        if ($target.hasClass('payment-amount')) {
            e.preventDefault();
            e.stopImmediatePropagation();
            $target.change();
            calculate_balance_due();
            $target.blur();
            var balance_span = $('#modal_payment').find('span.balance_due');
            if (balance_span.length) {
                balance_span.attr('tabindex', '-1').focus();
            }
            pos_payment_enter_step = 1;
            return;
        }
        if (pos_payment_enter_step === 1) {
            e.preventDefault();
            e.stopImmediatePropagation();
            pos_payment_confirm_open = false;
            pos_payment_confirm_armed = false;
            calculate_balance_due();
            var change_text = $('#modal_payment').find('span.change_return_span').text();
            swal({
                title: 'RETURN',
                text: change_text,
                icon: 'info',
                buttons: true,
                dangerMode: false,
                className: 'pos-confirm-swal',
            }).then(function(willPay) {
                pos_payment_confirm_open = false;
                pos_payment_confirm_armed = false;
                if (willPay) {
                    $('#pos-save').trigger('click');
                } else {
                    pos_payment_enter_step = 0;
                    focus_payment_amount_field();
                }
            });
            setTimeout(function() {
                pos_payment_confirm_open = true;
                pos_payment_confirm_armed = true;
                focus_swal_confirm(10);
            }, 200);
            return;
        }
        e.preventDefault();
        e.stopImmediatePropagation();
        focus_payment_amount_field();
    });

    document.addEventListener('keydown', function(e) {
        if (!pos_payment_confirm_open || !pos_payment_confirm_armed || e.which !== 13) {
            return;
        }
        if (!is_swal_open()) {
            return;
        }
        e.preventDefault();
        e.stopImmediatePropagation();
        pos_payment_confirm_armed = false;
        trigger_swal_confirm();
    }, true);

    //Finalize without showing payment options
    $('button.pos-express-finalize').click(function() {

        //Check if product is present or not.
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }

        if ($('#reward_point_enabled').length) {
            var validate_rp = isValidatRewardPoint();
            if (!validate_rp['is_valid']) {
                toastr.error(validate_rp['msg']);
                return false;
            }
        }

        var pay_method = $(this).data('pay_method');

        //If pay method is credit sale submit form
        if (pay_method == 'credit_sale') {
            $('#is_credit_sale').val(1);
            pos_form_obj.submit();
            return true;
        } else {
            if ($('#is_credit_sale').length) {
                $('#is_credit_sale').val(0);
            }
        }

        //Check for remaining balance & add it in 1st payment row
        var total_payable = __read_number($('input#final_total_input'));
        var total_paying = __read_number($('input#total_paying_input'));
        if (total_payable > total_paying) {
            var bal_due = total_payable - total_paying;

            var first_row = $('#payment_rows_div')
                .find('.payment-amount')
                .first();
            var first_row_val = __read_number(first_row);
            first_row_val = first_row_val + bal_due;
            __write_number(first_row, first_row_val);
            first_row.trigger('change');
        }

        //Change payment method.
        var payment_method_dropdown = $('#payment_rows_div')
            .find('.payment_types_dropdown')
            .first();
        
            payment_method_dropdown.val(pay_method);
            payment_method_dropdown.change();
        if (pay_method == 'card') {
            $('div#card_details_modal').modal('show');
        } else if (pay_method == 'suspend') {
            $('div#confirmSuspendModal').modal('show');
        } else {
            pos_form_obj.submit();
        }
    });

    $('div#card_details_modal').on('shown.bs.modal', function(e) {
        $('input#card_number').focus();
    });

    $('div#confirmSuspendModal').on('shown.bs.modal', function(e) {
        $(this)
            .find('textarea')
            .focus();
    });

    //on save card details
    $('button#pos-save-card').click(function() {
        $('input#card_number_0').val($('#card_number').val());
        $('input#card_holder_name_0').val($('#card_holder_name').val());
        $('input#card_transaction_number_0').val($('#card_transaction_number').val());
        $('select#card_type_0').val($('#card_type').val());
        $('input#card_month_0').val($('#card_month').val());
        $('input#card_year_0').val($('#card_year').val());
        $('input#card_security_0').val($('#card_security').val());

        $('div#card_details_modal').modal('hide');
        pos_form_obj.submit();
    });

    $('button#pos-suspend').click(function() {
        $('input#is_suspend').val(1);
        $('div#confirmSuspendModal').modal('hide');
        pos_form_obj.submit();
        $('input#is_suspend').val(0);
    });

    //fix select2 input issue on modal
    $('#modal_payment')
        .find('.select2')
        .each(function() {
            $(this).select2({
                dropdownParent: $('#modal_payment'),
            });
        });

    $('button#add-payment-row').click(function() {
        var row_index = $('#payment_row_index').val();
        var location_id = $('input#location_id').val();
        $.ajax({
            method: 'POST',
            url: '/sells/pos/get_payment_row',
            data: { row_index: row_index, location_id: location_id },
            dataType: 'html',
            success: function(result) {
                if (result) {
                    var appended = $('#payment_rows_div').append(result);

                    var total_payable = __read_number($('input#final_total_input'));
                    var total_paying = __read_number($('input#total_paying_input'));
                    var b_due = total_payable - total_paying;
                    $(appended)
                        .find('input.payment-amount')
                        .focus();
                    $(appended)
                        .find('input.payment-amount')
                        .last()
                        .val(__currency_trans_from_en(b_due, false))
                        .change()
                        .select();
                    __select2($(appended).find('.select2'));
                    $(appended).find('#method_' + row_index).change();
                    $('#payment_row_index').val(parseInt(row_index) + 1);
                }
            },
        });
    });

    $(document).on('click', '.remove_payment_row', function() {
        swal({
            title: LANG.sure,
            icon: 'warning',
            buttons: true,
            dangerMode: true,
        }).then(willDelete => {
            if (willDelete) {
                $(this)
                    .closest('.payment_row')
                    .remove();
                calculate_balance_due();
            }
        });
    });

    pos_form_validator = pos_form_obj.validate({
        submitHandler: function(form) {
            // var total_payble = __read_number($('input#final_total_input'));
            // var total_paying = __read_number($('input#total_paying_input'));
            var cnf = true;

            //Ignore if the difference is less than 0.5
            if ($('input#in_balance_due').val() >= 0.5) {
                cnf = confirm(LANG.paid_amount_is_less_than_payable);
                // if( total_payble > total_paying ){
                // 	cnf = confirm( LANG.paid_amount_is_less_than_payable );
                // } else if(total_payble < total_paying) {
                // 	alert( LANG.paid_amount_is_more_than_payable );
                // 	cnf = false;
                // }
            }

            var total_advance_payments = 0;
            $('#payment_rows_div').find('select.payment_types_dropdown').each( function(){
                if ($(this).val() == 'advance') {
                    total_advance_payments++
                };
            });

            if (total_advance_payments > 1) {
                alert(LANG.advance_payment_cannot_be_more_than_once);
                return false;
            }

            var is_msp_valid = true;
            //Validate minimum selling price if hidden
            $('.pos_unit_price_inc_tax').each( function(){
                if (!$(this).is(":visible") && $(this).data('rule-min-value')) {
                    var val = __read_number($(this));
                    var error_msg_td = $(this).closest('tr').find('.pos_line_total_text').closest('td');
                    if (val > $(this).data('rule-min-value')) {
                        is_msp_valid = false;
                        error_msg_td.append( '<label class="error">' + $(this).data('msg-min-value') + '</label>');
                    } else {
                        error_msg_td.find('label.error').remove();
                    }
                }
            });

            if (!is_msp_valid) {
                return false;
            }

            if (cnf) {
                disable_pos_form_actions();

                var data = $(form).serialize();
                data = data + '&status=final';
                var url = $(form).attr('action');
                $.ajax({
                    method: 'POST',
                    url: url,
                    data: data,
                    dataType: 'json',
                    success: function(result) {
                        if (result.success == 1) {
                            if (result.whatsapp_link) {
                                window.open(result.whatsapp_link);
                            }
                            $('#modal_payment').modal('hide');
                            toastr.success(result.msg);

                            reset_pos_form();

                            //Check if enabled or not
                            if (result.receipt.is_enabled) {
                                pos_print(result.receipt);
                            }
                        } else {
                            toastr.error(result.msg);
                        }

                        enable_pos_form_actions();
                    },
                });
            }
            return false;
        },
    });

    $(document).on('change', '.payment-amount', function() {
        calculate_balance_due();
    });

    //Update discount
    $('button#posEditDiscountModalUpdate').click(function() {

        //if discount amount is not valid return false
        if (!$("#discount_amount_modal").valid()) {
            return false;
        }
        //Close modal
        $('div#posEditDiscountModal').modal('hide');

        //Update values
        $('input#discount_type').val($('select#discount_type_modal').val());
        __write_number($('input#discount_amount'), __read_number($('input#discount_amount_modal')));

        if ($('#reward_point_enabled').length) {
            var reward_validation = isValidatRewardPoint();
            if (!reward_validation['is_valid']) {
                toastr.error(reward_validation['msg']);
                $('#rp_redeemed_modal').val(0);
                $('#rp_redeemed_modal').change();
            }
            updateRedeemedAmount();
        }

        pos_total_row();
    });

    //Shipping
    $('button#posShippingModalUpdate').click(function() {
        //Close modal
        $('div#posShippingModal').modal('hide');

        //update shipping details
        $('input#shipping_details').val($('#shipping_details_modal').val());

        $('input#shipping_address').val($('#shipping_address_modal').val());
        $('input#shipping_status').val($('#shipping_status_modal').val());
        $('input#delivered_to').val($('#delivered_to_modal').val());
        $('input#delivery_person').val($('#delivery_person_modal').val());

        //Update shipping charges
        __write_number(
            $('input#shipping_charges'),
            __read_number($('input#shipping_charges_modal'))
        );

        //$('input#shipping_charges').val(__read_number($('input#shipping_charges_modal')));

        pos_total_row();
    });

    $('#posShippingModal').on('shown.bs.modal', function() {
        $('#posShippingModal')
            .find('#shipping_details_modal')
            .filter(':visible:first')
            .focus()
            .select();
            // $('.select2-selection__rendered').css('padding-right', '150px');
    });

    $(document).on('shown.bs.modal', '.row_edit_product_price_model', function() {
        $('.row_edit_product_price_model')
            .find('input')
            .filter(':visible:first')
            .focus()
            .select();
    });

    //Update Order tax
    $('button#posEditOrderTaxModalUpdate').click(function() {
        //Close modal
        $('div#posEditOrderTaxModal').modal('hide');

        var tax_obj = $('select#order_tax_modal');
        var tax_id = tax_obj.val();
        var tax_rate = tax_obj.find(':selected').data('rate');

        $('input#tax_rate_id').val(tax_id);

        __write_number($('input#tax_calculation_amount'), tax_rate);
        pos_total_row();
    });

    $(document).on('click', '.add_new_customer', function() {
        $('#customer_id').select2('close');
        var name = $(this).data('name');
        $('.contact_modal')
            .find('input#name')
            .val(name);
        $('.contact_modal')
            .find('select#contact_type')
            .val('customer')
            .closest('div.contact_type_div')
            .addClass('hide');
        $('.contact_modal').modal('show');
    });
    $('form#quick_add_contact')
        .submit(function(e) {
            e.preventDefault();
        })
        .validate({
            rules: {
                contact_id: {
                    remote: {
                        url: '/contacts/check-contacts-id',
                        type: 'post',
                        data: {
                            contact_id: function() {
                                return $('#contact_id').val();
                            },
                            hidden_id: function() {
                                return $('#hidden_id').val() || '';
                            },
                        },
                    },
                },
                // tax_number remote validation removed - now handled with sweet alert
            },
            messages: {
                contact_id: {
                    required: LANG.contact_id_required,
                    remote: LANG.contact_id_already_exists,
                },
            },
            submitHandler: function(form) {
                checkTaxNumberAndSubmitQuick(form);
            },
        });

    function checkTaxNumberAndSubmitQuick(form) {
        // Check if tax_number field exists and has a value
        if ($('#tax_number').length && $('#tax_number').val().trim() !== '') {
            $.ajax({
                method: 'POST',
                url: base_path + '/contacts/check-tax-number',
                dataType: 'json',
                data: {
                    contact_id: $('#hidden_id').val(),
                    tax_number: $('#tax_number').val(),
                },
                success: function(result) {
                    if (result.is_tax_number_exists == true) {
                        swal({
                            title: LANG.sure,
                            text: result.msg,
                            icon: 'warning',
                            buttons: true,
                            dangerMode: true,
                        }).then(willContinue => {
                            if (willContinue) {
                                checkMobileAndSubmitQuick(form);
                            } else {
                                $('#tax_number').select();
                            }
                        });
                    } else {
                        checkMobileAndSubmitQuick(form);
                    }
                },
            });
        } else {
            // If no tax number, proceed to mobile check
            checkMobileAndSubmitQuick(form);
        }
    }

    function checkMobileAndSubmitQuick(form) {
        $.ajax({
            method: 'POST',
            url: base_path + '/check-mobile',
            dataType: 'json',
            data: {
                contact_id: function() {
                    return $('#hidden_id').val();
                },
                mobile_number: function() {
                    return $('#mobile').val();
                },
            },
            success: function(result) {
                if (result.is_mobile_exists == true) {
                    swal({
                        title: LANG.sure,
                        text: result.msg,
                        icon: 'warning',
                        buttons: true,
                        dangerMode: true,
                    }).then(willContinue => {
                        if (willContinue) {
                            submitQuickContactForm(form);
                        } else {
                            $('#mobile').select();
                        }
                    });
                    
                } else {
                    submitQuickContactForm(form);
                }
            },
        });
    }

    $('.contact_modal').on('hidden.bs.modal', function() {
        $('form#quick_add_contact')
            .find('button[type="submit"]')
            .removeAttr('disabled');
        $('form#quick_add_contact')[0].reset();
    });

    //Updates for add sell
    $('select#discount_type, input#discount_amount, input#shipping_charges, \
        input#rp_redeemed_amount').change(function() {
        pos_total_row();
    });
    $('select#tax_rate_id').change(function() {
        var tax_rate = $(this)
            .find(':selected')
            .data('rate');
        __write_number($('input#tax_calculation_amount'), tax_rate);
        pos_total_row();
    });
    //Datetime picker
    $('#transaction_date').datetimepicker({
        format: moment_date_format + ' ' + moment_time_format,
        ignoreReadonly: true,
    });

    //Direct sell submit
    sell_form = $('form#add_sell_form');
    if ($('form#edit_sell_form').length) {
        sell_form = $('form#edit_sell_form');
        pos_total_row();
    }
    sell_form_validator = sell_form.validate({
        rules: {
            invoice_no: {
                remote: {
                    url: '/sell/check-invoice-number',
                    type: 'post',
                    data: {
                        invoice_no: function() {
                            return $('#invoice_no').val();
                        },
                        transaction_id: function() {
                            var id = '';
                            var editForm = $('form#edit_sell_form');
                            if (editForm.length) {
                                id = editForm.data('transaction-id');
                            }
                            return id || '';
                        }
                    }
                }
            },
        },
        messages: {
            invoice_no: {
                remote: LANG.invoice_number_already_exists,
            },
        },
    });

    $('button#submit-sell, button#save-and-print').click(function(e) {
        //Check if product is present or not.
        if ($('table#pos_table tbody').find('.product_row').length <= 0) {
            toastr.warning(LANG.no_products_added);
            return false;
        }

        var is_msp_valid = true;
        //Validate minimum selling price if hidden
        $('.pos_unit_price_inc_tax').each( function(){
            if (!$(this).is(":visible") && $(this).data('rule-min-value')) {
                var val = __read_number($(this));
                var error_msg_td = $(this).closest('tr').find('.pos_line_total_text').closest('td');
                if (val > $(this).data('rule-min-value')) {
                    is_msp_valid = false;
                    error_msg_td.append( '<label class="error">' + $(this).data('msg-min-value') + '</label>');
                } else {
                    error_msg_td.find('label.error').remove();
                }
            }
        });

        if (!is_msp_valid) {
            return false;
        }

        if ($(this).attr('id') == 'save-and-print') {
            $('#is_save_and_print').val(1);           
        } else {
            $('#is_save_and_print').val(0);
        }

        if ($('#reward_point_enabled').length) {
            var validate_rp = isValidatRewardPoint();
            if (!validate_rp['is_valid']) {
                toastr.error(validate_rp['msg']);
                return false;
            }
        }

        if ($('.enable_cash_denomination_for_payment_methods').length) {
            var payment_row = $('.enable_cash_denomination_for_payment_methods').closest('.payment_row');
            var is_valid = true;
            var payment_type = payment_row.find('.payment_types_dropdown').val();
            var denomination_for_payment_types = JSON.parse($('.enable_cash_denomination_for_payment_methods').val());
            if (denomination_for_payment_types.includes(payment_type) && payment_row.find('.is_strict').length && payment_row.find('.is_strict').val() === '1' ) {
                var payment_amount = __read_number(payment_row.find('.payment-amount'));
                var total_denomination = payment_row.find('input.denomination_total_amount').val();
                if (payment_amount != total_denomination ) {
                    is_valid = false;
                }
            }

            if (!is_valid) {
                payment_row.find('.cash_denomination_error').removeClass('hide');
                toastr.error(payment_row.find('.cash_denomination_error').text());
                e.preventDefault();
                return false;
            } else {
                payment_row.find('.cash_denomination_error').addClass('hide');
            }
        }

        if (sell_form.valid()) {
            window.onbeforeunload = null;
            $(this).attr('disabled', true);
            sell_form.submit();
        }
    });

    //REPAIR MODULE:check if repair module field is present send data to filter product
    var is_enabled_stock = null;
    if ($("#is_enabled_stock").length) {
        is_enabled_stock = $("#is_enabled_stock").val();
    }

    var device_model_id = null;
    if ($("#repair_model_id").length) {
        device_model_id = $("#repair_model_id").val();
    }

    //Show product list.
    get_product_suggestion_list(
        global_p_category_id,
        global_brand_id,
        $('input#location_id').val(),
        null,
        is_enabled_stock,
        device_model_id
    );
    
    $('select#select_location_id').on('change', function(e) {
        $('input#suggestion_page').val(1);
        var location_id = $('input#location_id').val();
        if (location_id != '' || location_id != undefined) {
            get_product_suggestion_list(
                global_p_category_id,
                global_brand_id,
                $('input#location_id').val(),
                null
            );
        }
        get_featured_products();
    });

// on click sub category in category drawer
    $('.product_category').on('click', function(e) {
        global_p_category_id = $(this).data('value');
        $('input#suggestion_page').val(1);
        var location_id = $('input#location_id').val();
        if (location_id != '' || location_id != undefined) {
            get_product_suggestion_list(
                global_p_category_id,
                global_brand_id,
                $('input#location_id').val(),
                null
            );
        }
        get_featured_products();
        $('.overlay-category').trigger('click');
    });

    //  function for show sub category 
    $('.main-category').on('click', function(){

        global_p_category_id = $(this).data('value');
        parent = $(this).data('parent');

        if (parent == 0) {
            get_product_suggestion_list(
                global_p_category_id,
                global_brand_id,
                $('input#location_id').val(),
                null
            );
            get_featured_products();
            $('.overlay-category').trigger('click');
        }
        else {
            var main_category = $(this).data('value');

            $('.main-category-div').hide();
            $('.'+ main_category).fadeIn();
            $('.category_heading').text('Sub Category ' + $(this).data('name'));
            $('.category-back').fadeIn();
        }
    })

    // function for back button in category 
    $('.category-back').on('click', function(){
        $('.main-category-div').fadeIn();
        $('.main-category-all').fadeIn();
        $('.all-sub-category').hide();
        $('.category-back').hide();
        $('.category_heading').text('Category');
    });

    // on click brand in brand drawer 
    $('.product_brand').on('click', function(e) {
        global_brand_id = $(this).data('value');
        $('input#suggestion_page').val(1);
        var location_id = $('input#location_id').val();

        if (location_id != '' || location_id != undefined) {
            get_product_suggestion_list(
                global_p_category_id,
                global_brand_id,
                $('input#location_id').val(),
                null
            );
        }
        get_featured_products();
        $('.overlay-brand').trigger('click');
    });

    // close side bar 

    $('.close-side-bar-category').on('click', function() {
        $('.overlay-category').trigger('click');
    });

    $('.close-side-bar-brand').on('click', function() {
        $('.overlay-brand').trigger('click');
    });


    

$(document).on('click', 'div.product_box', function() {
    //Check if location is not set then show error message.
    if ($('input#location_id').val() == '') {
        toastr.warning(LANG.select_location);
    } else {
        pos_product_row($(this).data('variation_id'));
    }
});

$(document).on('click', '.pos-product-edit-btn', function(e) {
    e.preventDefault();
    e.stopPropagation();
    var product_id = $(this).data('product_id');
    if (!product_id) {
        return;
    }
    var $modal = $('.edit_product_modal');
    if (!$modal.length) {
        return;
    }
    var pos_location_id = $('input#location_id').val();
    var url = '/products/' + product_id + '/edit-pos';
    if (pos_location_id) {
        url += '?location_id=' + encodeURIComponent(pos_location_id);
    }
    $modal.load(url, function() {
        if (typeof __select2 === 'function') {
            __select2($modal.find('.select2'), $modal);
        } else {
            $modal.find('.select2').select2({ dropdownParent: $modal });
        }
        $modal.modal('show');
    });
});

$(document).on('submit', 'form#pos_edit_product_form', function(e) {
    e.preventDefault();
    var $form = $(this);
    var $submit = $form.find('button[type="submit"]');
    var pos_location_id = $('input#location_id').val();
    if (pos_location_id) {
        var $posLocationInput = $form.find('input[name="pos_location_id"]');
        if (!$posLocationInput.length) {
            $posLocationInput = $('<input type="hidden" name="pos_location_id">').appendTo($form);
        }
        $posLocationInput.val(pos_location_id);
    }
    var data = $form.serialize();
    if ($submit.length) {
        $submit.prop('disabled', true);
    }
    $.ajax({
        method: 'POST',
        url: $form.attr('action'),
        data: data,
        dataType: 'json',
        success: function(result) {
            if (result && result.success) {
                toastr.success(result.msg || 'Updated');
                if (result.product) {
                    pos_update_local_index_item(result.product);
                    if (typeof result.product.variation_id !== 'undefined') {
                        pos_update_cart_stock(result.product.variation_id, result.product.qty_available, result.product.unit);
                    }
                }
                $('.edit_product_modal').modal('hide');
                var location_id = $('input#location_id').val();
                $('input#suggestion_page').val(1);
                get_product_suggestion_list(global_p_category_id, global_brand_id, location_id);
            } else {
                toastr.error((result && result.msg) ? result.msg : LANG.something_went_wrong);
            }
        },
        error: function() {
            toastr.error(LANG.something_went_wrong);
        },
        complete: function() {
            if ($submit.length) {
                $submit.prop('disabled', false);
            }
        }
    });
});

function pos_edit_calc_from_cost_margin() {
    var cost = __read_number($('#pos_edit_cost_price'));
    var margin = __read_number($('#pos_edit_margin'));
    if (isNaN(cost)) {
        cost = 0;
    }
    if (isNaN(margin)) {
        margin = 0;
    }
    var selling = cost + (cost * margin / 100);
    __write_number($('#pos_edit_selling_price'), selling);
}

function pos_edit_calc_from_cost_selling() {
    var cost = __read_number($('#pos_edit_cost_price'));
    var selling = __read_number($('#pos_edit_selling_price'));
    if (isNaN(cost) || cost === 0) {
        __write_number($('#pos_edit_margin'), 0);
        return;
    }
    var margin = ((selling - cost) / cost) * 100;
    __write_number($('#pos_edit_margin'), margin);
}

$(document).on('input', '#pos_edit_cost_price, #pos_edit_margin', function() {
    pos_edit_calc_from_cost_margin();
});

$(document).on('input', '#pos_edit_selling_price', function() {
    pos_edit_calc_from_cost_selling();
});

$(document).on('change', '#pos_edit_location_id', function() {
    var location_id = $(this).val();
    $('#current_quantity_location').val(location_id);
});

    $(document).on('shown.bs.modal', '.row_description_modal', function() {
        $(this)
            .find('textarea')
            .first()
            .focus();
    });

    //Press enter on search product to jump into last quantty and vice-versa
    $('#search_product').keydown(function(e) {
        var key = e.which;
        if (key == 13) {
            var input_val_enter = $(this).val();
            if (input_val_enter && input_val_enter.trim() !== '') {
                e.preventDefault();
                pos_request_suggestion_focus();
                return;
            }
        }
        if (key == 40 || key == 38) {
            var input_val_nav = $(this).val();
            if (input_val_nav && input_val_nav.trim() !== '') {
                e.preventDefault();
                pos_request_suggestion_focus();
                if (pos_suggestion_active) {
                    pos_set_active_suggestion(key == 40 ? 0 : -1);
                }
                return;
            }
        }
        if (key == 13) {
            var has_rows = $('#pos_table tbody tr').length > 0;
            var input_val = $(this).val();
            if (has_rows && (!input_val || input_val.trim() === '')) {
                e.preventDefault();
                $('#pos_table tbody tr:last')
                    .find('input.pos_quantity')
                    .focus()
                    .select();
                return;
            }
        }
        if (key == 32) {
            var input_val_space = $(this).val();
            if (!input_val_space || input_val_space.trim() === '') {
                e.preventDefault();
                $('#pos-finalize').first().trigger('click');
                return;
            }
        }
        if (key == 9) {
            // the tab key code
            e.preventDefault();
            if ($('#pos_table tbody tr').length > 0) {
                $('#pos_table tbody tr:last')
                    .find('input.pos_quantity')
                    .focus()
                    .select();
            }
        }
    });
    $(document).on('keydown', function(e) {
        if (!$(e.target).is('#search_product')) {
            return;
        }
        var key = e.which;
        var input_val = $(e.target).val();
        if (!input_val || input_val.trim() === '') {
            return;
        }
        if (key == 13 || key == 38 || key == 40) {
            e.preventDefault();
            pos_request_suggestion_focus();
        }
    });
    $(document).on('keydown', function(e) {
        if (!pos_suggestion_active) {
            return;
        }
        if (pos_is_modal_open()) {
            return;
        }
        var key = e.which;
        var $items = pos_get_suggestion_items();
        if (!$items.length) {
            pos_clear_active_suggestion();
            return;
        }

        if (key == 27) {
            e.preventDefault();
            pos_clear_active_suggestion();
            pos_focus_search(true);
            return;
        }

        if (key == 13) {
            e.preventDefault();
            var $active = $items.eq(pos_suggestion_index >= 0 ? pos_suggestion_index : 0);
            if ($active.length) {
                pos_product_row($active.data('variation_id'), null, null, 1);
                pos_clear_active_suggestion();
                pos_clear_search_input();
                pos_focus_last_qty_with_retry(0);
            }
            return;
        }

        if (key == 37 || key == 38 || key == 39 || key == 40) {
            e.preventDefault();
            var cols = pos_get_suggestion_columns($items);
            var current = pos_suggestion_index >= 0 ? pos_suggestion_index : 0;
            var nextIndex = current;

            if (key == 37) {
                nextIndex = current - 1;
            } else if (key == 39) {
                nextIndex = current + 1;
            } else if (key == 38) {
                nextIndex = current - cols;
                if (nextIndex < 0) {
                    var remainder = current % cols;
                    var lastRowStart = $items.length - ($items.length % cols || cols);
                    nextIndex = Math.min(lastRowStart + remainder, $items.length - 1);
                }
            } else if (key == 40) {
                nextIndex = current + cols;
                if (nextIndex >= $items.length) {
                    nextIndex = current % cols;
                }
            }
            pos_set_active_suggestion(nextIndex);
        }
    });
    $('#pos_table').on('keydown', 'input.pos_quantity', function(e) {
        var key = e.which;
        if (key == 13) {
            // the enter key code
            if (!$('#__is_mobile').length) {
                e.preventDefault();
                e.stopImmediatePropagation();
                $(this).change();
                $('#search_product').focus();
            }
        }
        if (key == 32) {
            if (!$('#__is_mobile').length) {
                e.preventDefault();
                e.stopImmediatePropagation();
                $(this).change();
                $('#pos-finalize').first().trigger('click');
            }
        }
    });

    $('#exchange_rate').change(function() {
        var curr_exchange_rate = 1;
        if ($(this).val()) {
            curr_exchange_rate = __read_number($(this));
        }
        var total_payable = __read_number($('input#final_total_input'));
        var shown_total = total_payable * curr_exchange_rate;
        $('span#total_payable').text(__currency_trans_from_en(shown_total, false));
    });

    $('select#price_group').change(function() {
        $('input#hidden_price_group').val($(this).val());
        setTimeout(function() {
            pos_load_local_index(true);
        }, 50);
    });

    //Quick add product
    $(document).on('click', 'button.pos_add_quick_product', function() {
        var url = $(this).data('href');
        var container = $(this).data('container');
        $.ajax({
            url: url + '?product_for=pos',
            dataType: 'html',
            success: function(result) {
                $(container)
                    .html(result)
                    .modal('show');
                $('.os_exp_date').datepicker({
                    autoclose: true,
                    format: 'dd-mm-yyyy',
                    clearBtn: true,
                });
            },
        });
    });

    $(document).on('change', 'form#quick_add_product_form input#single_dpp', function() {
        var unit_price = __read_number($(this));
        $('table#quick_product_opening_stock_table tbody tr').each(function() {
            var input = $(this).find('input.unit_price');
            __write_number(input, unit_price);
            input.change();
        });
    });

    $(document).on('quickProductAdded', function(e) {
        //Check if location is not set then show error message.
        if ($('input#location_id').val() == '') {
            toastr.warning(LANG.select_location);
        } else {
            pos_product_row(e.variation.id);
        }
    });

    $('div.view_modal').on('show.bs.modal', function() {
        __currency_convert_recursively($(this));
    });

    $('table#pos_table').on('change', 'select.sub_unit', function() {
        var tr = $(this).closest('tr');
        var base_unit_selling_price = tr.find('input.hidden_base_unit_sell_price').val();

        var selected_option = $(this).find(':selected');

        var multiplier = parseFloat(selected_option.data('multiplier'));

        var allow_decimal = parseInt(selected_option.data('allow_decimal'));

        tr.find('input.base_unit_multiplier').val(multiplier);

        var unit_sp = base_unit_selling_price * multiplier;

        var sp_element = tr.find('input.pos_unit_price');
        __write_number(sp_element, unit_sp);

        sp_element.change();

        var qty_element = tr.find('input.pos_quantity');
        var base_max_avlbl = qty_element.data('qty_available');
        var error_msg_line = 'pos_max_qty_error';

        if (tr.find('select.lot_number').length > 0) {
            var lot_select = tr.find('select.lot_number');
            if (lot_select.val()) {
                base_max_avlbl = lot_select.find(':selected').data('qty_available');
                error_msg_line = 'lot_max_qty_error';
            }
        }

        qty_element.attr('data-decimal', allow_decimal);
        var abs_digit = true;
        if (allow_decimal) {
            abs_digit = false;
        }
        qty_element.rules('add', {
            abs_digit: abs_digit,
        });

        if (base_max_avlbl) {
            var max_avlbl = parseFloat(base_max_avlbl) / multiplier;
            var formated_max_avlbl = __number_f(max_avlbl);
            var unit_name = selected_option.data('unit_name');
            var max_err_msg = __translate(error_msg_line, {
                max_val: formated_max_avlbl,
                unit_name: unit_name,
            });
            qty_element.attr('data-rule-max-value', max_avlbl);
            qty_element.attr('data-msg-max-value', max_err_msg);
            qty_element.rules('add', {
                'max-value': max_avlbl,
                messages: {
                    'max-value': max_err_msg,
                },
            });
            qty_element.trigger('change');
        }
        adjustComboQty(tr);
    });

    //Confirmation before page load.
    window.onbeforeunload = function() {
        if($('form#edit_pos_sell_form').length == 0){
            if($('table#pos_table tbody tr').length > 0) {
                return LANG.sure;
            } else {
                return null;
            }
        }
    }
    $(window).resize(function() {
        var win_height = $(window).height();
        div_height = __calculate_amount('percentage', 63, win_height);
        // $('div.pos_product_div').css('min-height', div_height + 'px');
        // $('div.pos_product_div').css('max-height', div_height + 'px');
    });

    //Used for weighing scale barcode
    $('#weighing_scale_modal').on('shown.bs.modal', function (e) {

        //Attach the scan event
        onScan.attachTo(document, {
            suffixKeyCodes: [13], // enter-key expected at the end of a scan
            reactToPaste: true, // Compatibility to built-in scanners in paste-mode (as opposed to keyboard-mode)
            onScan: function(sCode, iQty) {
                console.log('Scanned: ' + iQty + 'x ' + sCode); 
                $('input#weighing_scale_barcode').val(sCode);
                $('button#weighing_scale_submit').trigger('click');
            },
            onScanError: function(oDebug) {
                console.log(oDebug); 
            },
            minLength: 2
            // onKeyDetect: function(iKeyCode){ // output all potentially relevant key events - great for debugging!
            //     console.log('Pressed: ' + iKeyCode);
            // }
        });

        $('input#weighing_scale_barcode').focus();
    });

    $('#weighing_scale_modal').on('hide.bs.modal', function (e) {
        //Detach from the document once modal is closed.
        onScan.detachFrom(document);
    });

    $('button#weighing_scale_submit').click(function(){

        var price_group = '';
        if ($('#price_group').length > 0) {
            price_group = $('#price_group').val();
        }

        if($('#weighing_scale_barcode').val().length > 0){
            pos_product_row(null, null, $('#weighing_scale_barcode').val());
            $('#weighing_scale_modal').modal('hide');
            $('input#weighing_scale_barcode').val('');
        } else{
            $('input#weighing_scale_barcode').focus();
        }
    });

    $('#show_featured_products').click( function(){
        if (!$('#featured_products_box').is(':visible')) {
            $('#featured_products_box').fadeIn();
        } else {
            $('#featured_products_box').fadeOut();
        }
    });
    validate_discount_field();
    set_payment_type_dropdown();
    if ($('#__is_mobile').length) {
        $('.pos_form_totals').css('margin-bottom', $('.pos-form-actions').height() - 30);
    }

    setInterval(function () {
        if ($('span.curr_datetime').length) {
            $('span.curr_datetime').html(__current_datetime());
        }
    }, 60000);

    set_search_fields();
    init_pos_fullscreen();
});

function init_pos_fullscreen() {
    if (typeof screenfull === 'undefined' || !screenfull.isEnabled) {
        return;
    }
    if (screenfull.isFullscreen) {
        return;
    }
    var attempted = false;
    var requestFull = function() {
        if (attempted) {
            return;
        }
        attempted = true;
        document.removeEventListener('click', requestFull, true);
        document.removeEventListener('keydown', requestFull, true);
        document.removeEventListener('touchstart', requestFull, true);
        try {
            screenfull.request(document.documentElement);
        } catch (e) {
            // ignore
        }
    };
    document.addEventListener('click', requestFull, true);
    document.addEventListener('keydown', requestFull, true);
    document.addEventListener('touchstart', requestFull, true);
}

function set_payment_type_dropdown() {
    var payment_settings = $('#location_id').data('default_payment_accounts');
    payment_settings = payment_settings ? payment_settings : [];
    enabled_payment_types = [];
    for (var key in payment_settings) {
        if (payment_settings[key] && payment_settings[key]['is_enabled']) {
            enabled_payment_types.push(key);
        }
    }
    if (enabled_payment_types.length) {
        $(".payment_types_dropdown > option").each(function() {
            //skip if advance
            if ($(this).val() && $(this).val() != 'advance') {
                if (enabled_payment_types.indexOf($(this).val()) != -1) {
                    $(this).removeClass('hide');
                } else {
                    $(this).addClass('hide');
                }
            }
        });
    }
}

function get_featured_products() {
    var location_id = $('#location_id').val();
    if (location_id && $('#featured_products_box').length > 0) {
        $.ajax({
            method: 'GET',
            url: '/sells/pos/get-featured-products/' + location_id,
            dataType: 'html',
            success: function(result) {
                if (result) {
                    $('#feature_product_div').removeClass('hide');
                    $('#featured_products_box').html(result);
                } else {
                    $('#feature_product_div').addClass('hide');
                    $('#featured_products_box').html('');
                }
            },
        });
    } else {
        $('#feature_product_div').addClass('hide');
        $('#featured_products_box').html('');
    }
}

function get_product_suggestion_list(category_id, brand_id, location_id, url = null, is_enabled_stock = null, repair_model_id = null) {
    if($('div#product_list_body').length == 0) {
        return false;
    }

    if (pos_local_product_list_enabled) {
        if (!pos_local_index.loaded) {
            if (!pos_local_index.loading) {
                pos_load_local_index(false);
            }
            if (parseInt($('input#suggestion_page').val() || 1, 10) === 1) {
                $('div#product_list_body').html('<div class="col-md-12"><h4 class="text-center">' + ((typeof LANG !== 'undefined' && LANG.processing) ? LANG.processing : 'Loading...') + '</h4></div>');
            }
            return;
        }
        var local_page = parseInt($('input#suggestion_page').val() || 1, 10);
        var local_filters = {
            category_id: (category_id && category_id !== 'all') ? pos_parse_int(category_id) : null,
            brand_id: (brand_id && brand_id !== 'all') ? pos_parse_int(brand_id) : null,
            repair_model_id: repair_model_id ? pos_parse_int(repair_model_id) : null,
            is_enabled_stock: (is_enabled_stock ? (is_enabled_stock === 'product' ? 1 : 0) : null),
            term: pos_search_term,
            search_fields: pos_get_search_fields()
        };
        pos_render_local_product_list(local_filters, local_page);
        return;
    }

    if (url == null) {
        url = '/sells/pos/get-product-suggestion';
    }
    $('#suggestion_page_loader').fadeIn(700);
    var page = $('input#suggestion_page').val();
    if (page == 1) {
        $('div#product_list_body').html('');
    }
    if ($('div#product_list_body').find('input#no_products_found').length > 0) {
        $('#suggestion_page_loader').fadeOut(700);
        return false;
    }
    var term = pos_search_term && pos_search_term.length >= 2 ? pos_search_term : null;
    $.ajax({
        method: 'GET',
        url: url,
        data: {
            category_id: category_id,
            brand_id: brand_id,
            location_id: location_id,
            page: page,
            term: term,
            is_enabled_stock: is_enabled_stock,
            repair_model_id: repair_model_id
        },
        dataType: 'html',
        success: function(result) {
            $('div#product_list_body').append(result);
            $('#suggestion_page_loader').fadeOut(700);
            pos_try_add_exact_from_suggestion(term);
            if (pos_pending_suggestion_focus) {
                pos_set_active_suggestion(0);
            }
        },
    });
}

//Get recent transactions
function get_recent_transactions(status, element_obj) {
    if (element_obj.length == 0) {
        return false;
    }
    var transaction_sub_type = $("#transaction_sub_type").val();
    $.ajax({
        method: 'GET',
        url: '/sells/pos/get-recent-transactions',
        data: { status: status , transaction_sub_type: transaction_sub_type},
        dataType: 'html',
        success: function(result) {
            element_obj.html(result);
            __currency_convert_recursively(element_obj);
        },
    });
}

function pos_try_add_existing_row(variation_id, quantity) {
    if (!variation_id) {
        return false;
    }
    var qty_to_add = (typeof quantity === 'number' && quantity > 0) ? quantity : 1;
    var is_added = false;
    $('#pos_table tbody')
        .find('tr')
        .each(function() {
            var row_v_id = $(this)
                .find('.row_variation_id')
                .val();
            var enable_sr_no = $(this)
                .find('.enable_sr_no')
                .val();
            var modifiers_exist = false;
            if ($(this).find('input.modifiers_exist').length > 0) {
                modifiers_exist = true;
            }

            if (
                row_v_id == variation_id &&
                enable_sr_no !== '1' &&
                !modifiers_exist &&
                !is_added
            ) {
                is_added = true;

                //Increment product quantity
                var qty_element = $(this).find('.pos_quantity');
                var qty = __read_number(qty_element);
                __write_number(qty_element, qty + qty_to_add);
                qty_element.change();

                round_row_to_iraqi_dinnar($(this));
                pos_mark_active_row($(this), true);

                if (!$('#__is_mobile').length) {
                    $('input#search_product')
                        .focus()
                        .select();
                }
            }
        });

    return is_added;
}

function pos_enqueue_row(payload) {
    pos_row_queue.push(payload);
    pos_process_row_queue();
}

function pos_process_row_queue() {
    if (pos_row_request_in_flight) {
        return;
    }
    if (!pos_row_queue.length) {
        return;
    }
    var payload = pos_row_queue.shift();

    if (payload.item_addtn_method != 0 && payload.variation_id) {
        if (pos_try_add_existing_row(payload.variation_id, payload.quantity)) {
            setTimeout(pos_process_row_queue, 0);
            return;
        }
    }

    pos_row_request_in_flight = true;

    var product_row = $('input#product_row_count').val();
    var location_id = payload.location_id || $('input#location_id').val();

    $.ajax({
        method: 'GET',
        url: '/sells/pos/get_product_row/' + payload.variation_id + '/' + location_id,
        data: {
            product_row: product_row,
            customer_id: payload.customer_id,
            is_direct_sell: payload.is_direct_sell,
            is_serial_no: payload.is_serial_no,
            price_group: payload.price_group,
            purchase_line_id: payload.purchase_line_id,
            weighing_scale_barcode: payload.weighing_scale_barcode,
            quantity: payload.quantity,
            is_sales_order: payload.is_sales_order,
            disable_qty_alert: payload.disable_qty_alert,
            is_draft: payload.is_draft
        },
        dataType: 'json',
        success: function(result) {
            if (result.success) {
                $('table#pos_table tbody')
                    .append(result.html_content)
                    .find('input.pos_quantity');
                //increment row count
                $('input#product_row_count').val(parseInt(product_row) + 1);
                var this_row = $('table#pos_table tbody')
                    .find('tr')
                    .last();
                pos_each_row(this_row);

                //For initial discount if present
                var line_total = __read_number(this_row.find('input.pos_line_total'));
                this_row.find('span.pos_line_total_text').text(line_total);

                pos_total_row();

                //Check if multipler is present then multiply it when a new row is added.
                if(__getUnitMultiplier(this_row) > 1){
                    this_row.find('select.sub_unit').trigger('change');
                }

                if (result.enable_sr_no == '1') {
                    var new_row = $('table#pos_table tbody')
                        .find('tr')
                        .last();
                    new_row.find('.row_edit_product_price_model').modal('show');
                }

                round_row_to_iraqi_dinnar(this_row);
                __currency_convert_recursively(this_row);
                pos_mark_active_row(this_row, true);

                if (!$('#__is_mobile').length) {
                    $('input#search_product')
                        .focus()
                        .select();
                }

                //Used in restaurant module
                if (result.html_modifier) {
                    $('table#pos_table tbody')
                        .find('tr')
                        .last()
                        .find('td:first')
                        .append(result.html_modifier);
                }

                //scroll bottom of items list
                var $pos_div = $(".pos_product_div");
                if ($pos_div.length) {
                    if (pos_row_queue.length > 0) {
                        $pos_div.scrollTop($pos_div.prop("scrollHeight"));
                    } else {
                        $pos_div.stop(true, true);
                        $pos_div.animate({ scrollTop: $pos_div.prop("scrollHeight")}, 200);
                    }
                }
            } else {
                toastr.error(result.msg);
                if (!$('#__is_mobile').length) {
                    $('input#search_product')
                        .focus()
                        .select();
                }
            }
        },
        error: function() {
            toastr.error(LANG.something_went_wrong);
            if (!$('#__is_mobile').length) {
                $('input#search_product')
                    .focus()
                    .select();
            }
        },
        complete: function() {
            pos_row_request_in_flight = false;
            setTimeout(pos_process_row_queue, 0);
        }
    });
}

function pos_has_pending_rows() {
    return pos_row_request_in_flight || pos_row_queue.length > 0;
}

//variation_id is null when weighing_scale_barcode is used.
function pos_product_row(variation_id = null, purchase_line_id = null, weighing_scale_barcode = null, quantity = 1) {

    //Get item addition method
    var item_addtn_method = 0;

    if (variation_id != null && $('#item_addition_method').length) {
        item_addtn_method = parseInt($('#item_addition_method').val(), 10) || 0;
    }

    if (item_addtn_method != 0) {
        if (pos_try_add_existing_row(variation_id, quantity)) {
            return;
        }
    }

    var location_id = $('input#location_id').val();
    var customer_id = $('select#customer_id').val();
    var is_direct_sell = false;
    if (
        $('input[name="is_direct_sale"]').length > 0 &&
        $('input[name="is_direct_sale"]').val() == 1
    ) {
        is_direct_sell = true;
    }

    var disable_qty_alert = false;

    if ($('#disable_qty_alert').length) {
        disable_qty_alert = true;
    }

    var is_sales_order = $('#sale_type').length && $('#sale_type').val() == 'sales_order' ? true : false;

    var price_group = '';
    if ($('#price_group').length > 0) {
        price_group = parseInt($('#price_group').val());
    }

    //If default price group present
    if ($('#default_price_group').length > 0 && 
        price_group === '') {
        price_group = $('#default_price_group').val();
    }

    //If types of service selected give more priority
    if ($('#types_of_service_price_group').length > 0 && 
        $('#types_of_service_price_group').val()) {
        price_group = $('#types_of_service_price_group').val();
    }

    var is_draft=false;
    if($('#status') && ($('#status').val()=='quotation' || 
    $('#status').val()=='draft')) {
        is_draft=true;
    }

    var is_serial_no = false;

    if (
        $('input[name="is_serial_no"]').length > 0 &&
        $('input[name="is_serial_no"]').val() == 1
    ) {
        is_serial_no = true;
    }

    pos_enqueue_row({
        variation_id: variation_id,
        purchase_line_id: purchase_line_id,
        weighing_scale_barcode: weighing_scale_barcode,
        quantity: quantity,
        location_id: location_id,
        customer_id: customer_id,
        is_direct_sell: is_direct_sell,
        is_serial_no: is_serial_no,
        price_group: price_group,
        is_sales_order: is_sales_order,
        disable_qty_alert: disable_qty_alert,
        is_draft: is_draft,
        item_addtn_method: item_addtn_method
    });
}

//Update values for each row
function pos_each_row(row_obj) {
    var unit_price = __read_number(row_obj.find('input.pos_unit_price'));

    var discounted_unit_price = calculate_discounted_unit_price(row_obj);
    var tax_rate = row_obj
        .find('select.tax_id')
        .find(':selected')
        .data('rate');

    var unit_price_inc_tax =
        discounted_unit_price + __calculate_amount('percentage', tax_rate, discounted_unit_price);
    __write_number(row_obj.find('input.pos_unit_price_inc_tax'), unit_price_inc_tax);

    var discount = __read_number(row_obj.find('input.row_discount_amount'));

    if (discount > 0) {
        var qty = __read_number(row_obj.find('input.pos_quantity'));
        var line_total = qty * unit_price_inc_tax;
        __write_number(row_obj.find('input.pos_line_total'), line_total);
    }

    //var unit_price_inc_tax = __read_number(row_obj.find('input.pos_unit_price_inc_tax'));

    __write_number(row_obj.find('input.item_tax'), unit_price_inc_tax - discounted_unit_price);
}

function pos_total_row() {
    var total_quantity = 0;
    var price_total = get_subtotal();
    $('table#pos_table tbody tr').each(function() {
        total_quantity = total_quantity + __read_number($(this).find('input.pos_quantity'));
    });

    //updating shipping charges
    $('span#shipping_charges_amount').text(
        __currency_trans_from_en(__read_number($('input#shipping_charges_modal')), false)
    );

    $('span.total_quantity').each(function() {
        $(this).html(__number_f(total_quantity));
    });

    //$('span.unit_price_total').html(unit_price_total);
    $('span.price_total').html(__currency_trans_from_en(price_total, false));
    calculate_billing_details(price_total);

    if (
        $('input[name="is_serial_no"]').length > 0 &&
        $('input[name="is_serial_no"]').val() == 1
    ) {
        update_serial_no();
    }
    // store on any update
    saveFormDataToLocalStorage();

}

function get_subtotal() {
    var price_total = 0;

    $('table#pos_table tbody tr').each(function() {
        price_total = price_total + __read_number($(this).find('input.pos_line_total'));
    });

    //Go through the modifier prices.
    $('input.modifiers_price').each(function() {
        var modifier_price = __read_number($(this));
        var modifier_quantity = $(this).closest('.product_modifier').find('.modifiers_quantity').val();
        var modifier_subtotal = modifier_price * modifier_quantity;
        price_total = price_total + modifier_subtotal;
    });

    return price_total;
}

function calculate_billing_details(price_total) {
    var discount = pos_discount(price_total);
    if ($('#reward_point_enabled').length) {
        total_customer_reward = $('#rp_redeemed_amount').val();
        discount = parseFloat(discount) + parseFloat(total_customer_reward);

        if ($('input[name="is_direct_sale"]').length <= 0) {
            $('span#total_discount').text(__currency_trans_from_en(discount, false));
        }
    }

    var order_tax = pos_order_tax(price_total, discount);

    //Add shipping charges.
    var shipping_charges = __read_number($('input#shipping_charges'));

    var additional_expense = 0;
    //calculate additional expenses
    if ($('input#additional_expense_value_1').length > 0) {
        additional_expense += __read_number($('input#additional_expense_value_1'));
    }
    if ($('input#additional_expense_value_2').length > 0) {
        additional_expense += __read_number($('input#additional_expense_value_2'))
    }
    if ($('input#additional_expense_value_3').length > 0) {
        additional_expense += __read_number($('input#additional_expense_value_3'))
    }
    if ($('input#additional_expense_value_4').length > 0) {
        additional_expense += __read_number($('input#additional_expense_value_4'))
    }

    //Add packaging charge
    var packing_charge = 0;
    if ($('#types_of_service_id').length > 0 && 
            $('#types_of_service_id').val()) {
        packing_charge = __calculate_amount($('#packing_charge_type').val(), 
            __read_number($('input#packing_charge')), price_total);

        $('#packing_charge_text').text(__currency_trans_from_en(packing_charge, false));
    }

    var total_payable = price_total + order_tax - discount + shipping_charges + packing_charge + additional_expense;

    var rounding_multiple = $('#amount_rounding_method').val() ? parseFloat($('#amount_rounding_method').val()) : 0;
    var round_off_data = __round(total_payable, rounding_multiple);
    var total_payable_rounded = round_off_data.number;

    var round_off_amount = round_off_data.diff;
    if (round_off_amount != 0) {
        $('span#round_off_text').text(__currency_trans_from_en(round_off_amount, false));
    } else {
        $('span#round_off_text').text(0);
    }
    $('input#round_off_amount').val(round_off_amount);

    __write_number($('input#final_total_input'), total_payable_rounded);
    var curr_exchange_rate = 1;
    if ($('#exchange_rate').length > 0 && $('#exchange_rate').val()) {
        curr_exchange_rate = __read_number($('#exchange_rate'));
    }
    var shown_total = total_payable_rounded * curr_exchange_rate;
    $('span#total_payable').text(__currency_trans_from_en(shown_total, false));

    $('span.total_payable_span').text(__currency_trans_from_en(total_payable_rounded, true));

    //Check if edit form then don't update price.
    if ($('form#edit_pos_sell_form').length == 0 && $('form#edit_sell_form').length == 0) {
        __write_number($('.payment-amount').first(), total_payable_rounded);
    }

    $(document).trigger('invoice_total_calculated');

    calculate_balance_due();
}

function pos_discount(total_amount) {
    var calculation_type = $('#discount_type').val();
    var calculation_amount = __read_number($('#discount_amount'));

    var discount = __calculate_amount(calculation_type, calculation_amount, total_amount);

    $('span#total_discount').text(__currency_trans_from_en(discount, false));

    return discount;
}

function pos_order_tax(price_total, discount) {
    var tax_rate_id = $('#tax_rate_id').val();
    var calculation_type = 'percentage';
    var calculation_amount = __read_number($('#tax_calculation_amount'));
    var total_amount = price_total - discount;

    if (tax_rate_id) {
        var order_tax = __calculate_amount(calculation_type, calculation_amount, total_amount);
    } else {
        var order_tax = 0;
    }

    $('span#order_tax').text(__currency_trans_from_en(order_tax, false));

    return order_tax;
}

function calculate_balance_due() {
    var total_payable = __read_number($('#final_total_input'));
    var total_paying = 0;
    $('#payment_rows_div')
        .find('.payment-amount')
        .each(function() {
            if (parseFloat($(this).val())) {
                total_paying += __read_number($(this));
            }
        });
    var bal_due = total_payable - total_paying;
    var change_return = 0;

    //change_return
    if (bal_due < 0 || Math.abs(bal_due) < 0.05) {
        __write_number($('input#change_return'), bal_due * -1);
        $('span.change_return_span').text(__currency_trans_from_en(bal_due * -1, true));
        change_return = bal_due * -1;
        bal_due = 0;
    } else {
        __write_number($('input#change_return'), 0);
        $('span.change_return_span').text(__currency_trans_from_en(0, true));
        change_return = 0;
        
    }

    if (change_return !== 0) {
        $('#change_return_payment_data').removeClass('hide');
    } else {
        $('#change_return_payment_data').addClass('hide');
    }

    __write_number($('input#total_paying_input'), total_paying);
    $('span.total_paying').text(__currency_trans_from_en(total_paying, true));

    __write_number($('input#in_balance_due'), bal_due);
    $('span.balance_due').text(__currency_trans_from_en(bal_due, true));

    __highlight(bal_due * -1, $('span.balance_due'));
    __highlight(change_return * -1, $('span.change_return_span'));
    // store payment details
    saveFormDataToLocalStorage();
}

function isValidPosForm() {
    flag = true;
    $('span.error').remove();

    if ($('select#customer_id').val() == null) {
        flag = false;
        error = '<span class="error">' + LANG.required + '</span>';
        $(error).insertAfter($('select#customer_id').parent('div'));
    }

    if ($('tr.product_row').length == 0) {
        flag = false;
        error = '<span class="error">' + LANG.no_products + '</span>';
        $(error).insertAfter($('input#search_product').parent('div'));
    }

    return flag;
}

function reset_pos_form(){

	//If on edit page then redirect to Add POS page
	if($('form#edit_pos_sell_form').length > 0){
		setTimeout(function() {
			window.location = $("input#pos_redirect_url").val();
		}, 4000);
		return true;
	}
	
    //reset all repair defects tags
    if ($("#repair_defects").length > 0) {
        tagify_repair_defects.removeAllTags();
    }

	if(pos_form_obj[0]){
		pos_form_obj[0].reset();
	}
	if(sell_form[0]){
		sell_form[0].reset();
	}
	set_default_customer();
	set_location();

	$('tr.product_row').remove();
	$('span.total_quantity, span.price_total, span#total_discount, span#order_tax, span#total_payable, span#shipping_charges_amount').text(0);
	$('span.total_payable_span', 'span.total_paying', 'span.balance_due').text(0);

	$('#modal_payment').find('.remove_payment_row').each( function(){
		$(this).closest('.payment_row').remove();
	});

    if ($('#is_credit_sale').length) {
        $('#is_credit_sale').val(0);
    }

	//Reset discount
	__write_number($('input#discount_amount'), $('input#discount_amount').data('default'));
	$('input#discount_type').val($('input#discount_type').data('default'));

	//Reset tax rate
	$('input#tax_rate_id').val($('input#tax_rate_id').data('default'));
	__write_number($('input#tax_calculation_amount'), $('input#tax_calculation_amount').data('default'));

	$('select.payment_types_dropdown').val('cash').trigger('change');
	$('#price_group').trigger('change');

	//Reset shipping
	__write_number($('input#shipping_charges'), $('input#shipping_charges').data('default'));
	$('input#shipping_details').val($('input#shipping_details').data('default'));
    $('input#shipping_address, input#shipping_status, input#delivered_to').val('');
	if($('input#is_recurring').length > 0){
		$('input#is_recurring').iCheck('update');
	};
    if($('input#is_kitchen_order').length > 0){
		$('input#is_kitchen_order').iCheck('update');
	};
    if($('#invoice_layout_id').length > 0){
        $('#invoice_layout_id').trigger('change');
    };
    $('span#round_off_text').text(0);

    //repair module extra  fields reset
    if ($('#repair_device_id').length > 0) {
        $('#repair_device_id').val('').trigger('change');
    }

    //Status is hidden in sales order
    if ($('#status').length > 0 && $('#status').is(":visible")) {
        $('#status').val('').trigger('change');
    }
    if ($('#transaction_date').length > 0) {
        $('#transaction_date').data("DateTimePicker").date(moment());
    }
    if ($('.paid_on').length > 0) {
        $('.paid_on').data("DateTimePicker").date(moment());
    }
    if ($('#commission_agent').length > 0) {
        $('#commission_agent').val('').trigger('change');
    } 

    //reset contact due
    $('.contact_due_text').find('span').text('');
    $('.contact_due_text').addClass('hide');

    $(document).trigger('sell_form_reset');

    // Set global_is_clear_local_storage to true to clear local storage
    global_is_clear_local_storage = true;
    saveFormDataToLocalStorage();
}

function set_default_customer() {
    var default_customer_id = $('#default_customer_id').val();
    var default_customer_name = $('#default_customer_name').val();
    var default_customer_balance = $('#default_customer_balance').val();
    var default_customer_address = $('#default_customer_address').val();
    var exists = default_customer_id ? $('select#customer_id option[value=' + default_customer_id + ']').length : 0;
    if (exists == 0 && default_customer_id) {
        $('select#customer_id').append(
            $('<option>', { value: default_customer_id, text: default_customer_name })
        );
    }
    $('#advance_balance_text').text(__currency_trans_from_en(default_customer_balance), true);
    $('#advance_balance').val(default_customer_balance);
    $('#shipping_address_modal').val(default_customer_address);
    if (default_customer_address) {
        $('#shipping_address').val(default_customer_address);
    }
    $('select#customer_id')
        .val(default_customer_id)
        .trigger('change');

    if ($('#default_selling_price_group').length) {
        $('#price_group').val($('#default_selling_price_group').val());
        $('#price_group').change();
    }

    //initialize tags input (tagify)
    if ($("textarea#repair_defects").length > 0 && !customer_set) {
        let suggestions = [];
        if ($("input#pos_repair_defects_suggestion").length > 0 && $("input#pos_repair_defects_suggestion").val().length > 2) {
            suggestions = JSON.parse($("input#pos_repair_defects_suggestion").val());    
        }
        let repair_defects = document.querySelector('textarea#repair_defects');
        tagify_repair_defects = new Tagify(repair_defects, {
                  whitelist: suggestions,
                  maxTags: 100,
                  dropdown: {
                    maxItems: 100,           // <- mixumum allowed rendered suggestions
                    classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
                    enabled: 0,             // <- show suggestions on focus
                    closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
                  }
                });
    }

    customer_set = true;
}

//Set the location and initialize printer
function set_location() {
    if ($('select#select_location_id').length == 1) {
        $('input#location_id').val($('select#select_location_id').val());
        $('input#location_id').data(
            'receipt_printer_type',
            $('select#select_location_id')
                .find(':selected')
                .data('receipt_printer_type')
        );
        $('input#location_id').data(
            'default_payment_accounts',
            $('select#select_location_id')
                .find(':selected')
                .data('default_payment_accounts')
        );

        $('input#location_id').attr(
            'data-default_price_group',
            $('select#select_location_id')
                .find(':selected')
                .data('default_price_group')
        );
    }

    if ($('input#location_id').val()) {
        $('input#search_product')
            .prop('disabled', false);
        if (!$('#__is_mobile').length) {
            $('input#search_product').focus();
        }
    } else {
        $('input#search_product').prop('disabled', true);
    }

    initialize_printer();
}

function initialize_printer() {
    if ($('input#location_id').data('receipt_printer_type') == 'printer') {
        initializeSocket();
    }
}

$('body').on('click', 'label', function(e) {
    var field_id = $(this).attr('for');
    if (field_id) {
        if ($('#' + field_id).hasClass('select2')) {
            $('#' + field_id).select2('open');
            return false;
        }
    }
});

$('body').on('focus', 'select', function(e) {
    var field_id = $(this).attr('id');
    if (field_id) {
        if ($('#' + field_id).hasClass('select2')) {
            $('#' + field_id).select2('open');
            return false;
        }
    }
});

function round_row_to_iraqi_dinnar(row) {
    if (iraqi_selling_price_adjustment) {
        var element = row.find('input.pos_unit_price_inc_tax');
        var unit_price = round_to_iraqi_dinnar(__read_number(element));
        __write_number(element, unit_price);
        element.change();
    }
}

function pos_print(receipt) {
    //If printer type then connect with websocket
    if (receipt.print_type == 'printer') {
        var content = receipt;
        content.type = 'print-receipt';

        //Check if ready or not, then print.
        if (socket != null && socket.readyState == 1) {
            socket.send(JSON.stringify(content));
        } else {
            initializeSocket();
            setTimeout(function() {
                socket.send(JSON.stringify(content));
            }, 700);
        }

    } else if (receipt.html_content != '') {
        var title = document.title;
        if (typeof receipt.print_title != 'undefined') {
            document.title = receipt.print_title;
        }

        //If printer type browser then print content
        $('#receipt_section').html(receipt.html_content);
        __currency_convert_recursively($('#receipt_section'));
        __print_receipt('receipt_section');

        setTimeout(function() {
            document.title = title;
        }, 1200);
    }
}

function calculate_discounted_unit_price(row) {
    var this_unit_price = __read_number(row.find('input.pos_unit_price'));
    var row_discounted_unit_price = this_unit_price;
    var row_discount_type = row.find('select.row_discount_type').val();
    var row_discount_amount = __read_number(row.find('input.row_discount_amount'));
    if (row_discount_amount) {
        if (row_discount_type == 'fixed') {
            row_discounted_unit_price = this_unit_price - row_discount_amount;
        } else {
            row_discounted_unit_price = __substract_percent(this_unit_price, row_discount_amount);
        }
    }

    return row_discounted_unit_price;
}

function get_unit_price_from_discounted_unit_price(row, discounted_unit_price) {
    var this_unit_price = discounted_unit_price;
    var row_discount_type = row.find('select.row_discount_type').val();
    var row_discount_amount = __read_number(row.find('input.row_discount_amount'));
    if (row_discount_amount) {
        if (row_discount_type == 'fixed') {
            this_unit_price = discounted_unit_price + row_discount_amount;
        } else {
            this_unit_price = __get_principle(discounted_unit_price, row_discount_amount, true);
        }
    }

    return this_unit_price;
}

//Update quantity if line subtotal changes
$('table#pos_table tbody').on('change', 'input.pos_line_total', function() {

    var subtotal = __read_number($(this));
    var tr = $(this).parents('tr');
    var quantity_element = tr.find('input.pos_quantity');
    var unit_price_inc_tax = __read_number(tr.find('input.pos_unit_price_inc_tax'));
    var quantity = subtotal / unit_price_inc_tax;
    __write_number(quantity_element, quantity);

    __write_number($(this), subtotal, false);


    if (sell_form_validator) {
        sell_form_validator.element(quantity_element);
    }
    if (pos_form_validator) {
        pos_form_validator.element(quantity_element);
    }
    tr.find('span.pos_line_total_text').text(__currency_trans_from_en(subtotal, true));

    pos_total_row();
});

$('div#product_list_body').on('scroll', function() {


    if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
        var page = parseInt($('#suggestion_page').val());
        page += 1;
        $('#suggestion_page').val(page);
        var location_id = $('input#location_id').val();
        var category_id = global_p_category_id;
        var brand_id = global_brand_id;

        var is_enabled_stock = null;
        if ($("#is_enabled_stock").length) {
            is_enabled_stock = $("#is_enabled_stock").val();
        }

        var device_model_id = null;
        if ($("#repair_model_id").length) {
            device_model_id = $("#repair_model_id").val();
        }

        get_product_suggestion_list(category_id, brand_id, location_id, null, is_enabled_stock, device_model_id);
    }
});

$(document).on('ifChecked', '#is_recurring', function() {
    $('#recurringInvoiceModal').modal('show');
});

$(document).on('shown.bs.modal', '#recurringInvoiceModal', function() {
    $('input#recur_interval').focus();
});

$(document).on('click', '#select_all_service_staff', function() {
    var val = $('#res_waiter_id').val();
    $('#pos_table tbody')
        .find('select.order_line_service_staff')
        .each(function() {
            $(this)
                .val(val)
                .change();
        });
});

$(document).on('click', '.print-invoice-link', function(e) {
    e.preventDefault();
    $.ajax({
        url: $(this).attr('href') + "?check_location=true",
        dataType: 'json',
        success: function(result) {
            if (result.success == 1) {
                //Check if enabled or not
                if (result.receipt.is_enabled) {
                    pos_print(result.receipt);
                }
            } else {
                toastr.error(result.msg);
            }

        },
    });
});

function getCustomerRewardPoints() {
    if ($('#reward_point_enabled').length <= 0) {
        return false;
    }
    var is_edit = $('form#edit_sell_form').length || 
    $('form#edit_pos_sell_form').length ? true : false;
    if (is_edit && !customer_set) {
        return false;
    }

    var customer_id = $('#customer_id').val();

    $.ajax({
        method: 'POST',
        url: '/sells/pos/get-reward-details',
        data: { 
            customer_id: customer_id
        },
        dataType: 'json',
        success: function(result) {
            $('#available_rp').text(result.points);
            $('#rp_redeemed_modal').data('max_points', result.points);
            updateRedeemedAmount();
            $('#rp_redeemed_amount').change()
        },
    });
}

function updateRedeemedAmount(argument) {
    var points = $('#rp_redeemed_modal').val().trim();
    points = points == '' ? 0 : parseInt(points);
    var amount_per_unit_point = parseFloat($('#rp_redeemed_modal').data('amount_per_unit_point'));
    var redeemed_amount = points * amount_per_unit_point;
    $('#rp_redeemed_amount_text').text(__currency_trans_from_en(redeemed_amount, true));
    $('#rp_redeemed').val(points);
    $('#rp_redeemed_amount').val(redeemed_amount);
}

$(document).on('change', 'select#customer_id', function(){
    var default_customer_id = $('#default_customer_id').val();
    if ($(this).val() == default_customer_id) {
        //Disable reward points for walkin customers
        if ($('#rp_redeemed_modal').length) {
            $('#rp_redeemed_modal').val('');
            $('#rp_redeemed_modal').change();
            $('#rp_redeemed_modal').attr('disabled', true);
            $('#available_rp').text('');
            updateRedeemedAmount();
            pos_total_row();
        }
    } else {
        if ($('#rp_redeemed_modal').length) {
            $('#rp_redeemed_modal').removeAttr('disabled');
        }
        getCustomerRewardPoints();
    }

    get_sales_orders();
});

$(document).on('change', '#rp_redeemed_modal', function(){
    var points = $(this).val().trim();
    points = points == '' ? 0 : parseInt(points);
    var amount_per_unit_point = parseFloat($(this).data('amount_per_unit_point'));
    var redeemed_amount = points * amount_per_unit_point;
    $('#rp_redeemed_amount_text').text(__currency_trans_from_en(redeemed_amount, true));
    var reward_validation = isValidatRewardPoint();
    if (!reward_validation['is_valid']) {
        toastr.error(reward_validation['msg']);
        $('#rp_redeemed_modal').select();
    }
});

$(document).on('change', '.direct_sell_rp_input', function(){
    updateRedeemedAmount();
    pos_total_row();
});

function isValidatRewardPoint() {
    var element = $('#rp_redeemed_modal');
    var points = element.val().trim();
    points = points == '' ? 0 : parseInt(points);

    var max_points = parseInt(element.data('max_points'));
    var is_valid = true;
    var msg = '';

    if (points == 0) {
        return {
            is_valid: is_valid,
            msg: msg
        }
    }

    var rp_name = $('input#rp_name').val();
    if (points > max_points) {
        is_valid = false;
        msg = __translate('max_rp_reached_error', {max_points: max_points, rp_name: rp_name});
    }

    var min_order_total_required = parseFloat(element.data('min_order_total'));

    var order_total = __read_number($('#final_total_input'));

    if (order_total < min_order_total_required) {
        is_valid = false;
        msg = __translate('min_order_total_error', {min_order: __currency_trans_from_en(min_order_total_required, true), rp_name: rp_name});
    }

    var output = {
        is_valid: is_valid,
        msg: msg,
    }

    return output;
}

function adjustComboQty(tr){
    if(tr.find('input.product_type').val() == 'combo'){
        var qty = __read_number(tr.find('input.pos_quantity'));
        var multiplier = __getUnitMultiplier(tr);

        tr.find('input.combo_product_qty').each(function(){
            $(this).val($(this).data('unit_quantity') * qty * multiplier);
        });
    }
}

$(document).on('change', '#types_of_service_id', function(){
    var types_of_service_id = $(this).val();
    var location_id = $('#location_id').val();

    if(types_of_service_id) {
        $.ajax({
            method: 'POST',
            url: '/sells/pos/get-types-of-service-details',
            data: { 
                types_of_service_id: types_of_service_id,
                location_id: location_id
            },
            dataType: 'json',
            success: function(result) {
                //reset form if price group is changed
                var prev_price_group = $('#types_of_service_price_group').val();
                if(result.price_group_id) {
                    $('#types_of_service_price_group').val(result.price_group_id);
                    $('#price_group_text').removeClass('hide');
                    $('#price_group_text span').text(result.price_group_name);
                } else {
                    $('#types_of_service_price_group').val('');
                    $('#price_group_text').addClass('hide');
                    $('#price_group_text span').text('');
                }
                $('#types_of_service_id').val(types_of_service_id);
                $('.types_of_service_modal').html(result.modal_html);
                
                if (prev_price_group != result.price_group_id) {
                    if ($('form#edit_pos_sell_form').length > 0) {
                        $('table#pos_table tbody').html('');
                        pos_total_row();
                    } else {
                        reset_pos_form();
                    }
                } else {
                    pos_total_row();
                }

                $('.types_of_service_modal').modal('show');
            },
        });
    } else {
        $('.types_of_service_modal').html('');
        $('#types_of_service_price_group').val('');
        $('#price_group_text').addClass('hide');
        $('#price_group_text span').text('');
        $('#packing_charge_text').text('');
        if ($('form#edit_pos_sell_form').length > 0) {
            $('table#pos_table tbody').html('');
            pos_total_row();
        } else {
            reset_pos_form();
        }
    }
});

$(document).on('change', 'input#packing_charge, #additional_expense_value_1, #additional_expense_value_2, \
        #additional_expense_value_3, #additional_expense_value_4', function() {
    pos_total_row();
});

$(document).on('click', '.service_modal_btn', function(e) {
    if ($('#types_of_service_id').val()) {
        $('.types_of_service_modal').modal('show');
    }
});

$(document).on('change', '.payment_types_dropdown', function(e) {
    var default_accounts = $('select#select_location_id').length ? 
                $('select#select_location_id')
                .find(':selected')
                .data('default_payment_accounts') : $('#location_id').data('default_payment_accounts');
    var payment_type = $(this).val();
    var payment_row = $(this).closest('.payment_row');
    if (payment_type && payment_type != 'advance') {
        var default_account = default_accounts && default_accounts[payment_type]['account'] ? 
            default_accounts[payment_type]['account'] : '';
        var row_index = payment_row.find('.payment_row_index').val();

        var account_dropdown = payment_row.find('select#account_' + row_index);
        if (account_dropdown.length && default_accounts) {
            account_dropdown.val(default_account);
            account_dropdown.change();
        }
    }

    //Validate max amount and disable account if advance 
    amount_element = payment_row.find('.payment-amount');
    account_dropdown = payment_row.find('.account-dropdown');
    if (payment_type == 'advance') {
        max_value = $('#advance_balance').val();
        msg = $('#advance_balance').data('error-msg');
        amount_element.rules('add', {
            'max-value': max_value,
            messages: {
                'max-value': msg,
            },
        });
        if (account_dropdown) {
            account_dropdown.prop('disabled', true);
            account_dropdown.closest('.form-group').addClass('hide');
        }
    } else {
        amount_element.rules("remove", "max-value");
        if (account_dropdown) {
            account_dropdown.prop('disabled', false); 
            account_dropdown.closest('.form-group').removeClass('hide');
        }    
    }
});

$(document).on('show.bs.modal', '#recent_transactions_modal', function () {
    get_recent_transactions('final', $('div#tab_final'));
});
$(document).on('shown.bs.tab', 'a[href="#tab_quotation"]', function () {
    get_recent_transactions('quotation', $('div#tab_quotation'));
});
$(document).on('shown.bs.tab', 'a[href="#tab_draft"]', function () {
    get_recent_transactions('draft', $('div#tab_draft'));
});

function disable_pos_form_actions(){
    if (!window.navigator.onLine) {
        return false;
    }

    $('div.pos-processing').show();
    $('#pos-save').attr('disabled', 'true');
    $('div.pos-form-actions').find('button').attr('disabled', 'true');
}

function enable_pos_form_actions(){
    $('div.pos-processing').hide();
    $('#pos-save').removeAttr('disabled');
    $('div.pos-form-actions').find('button').removeAttr('disabled');
}

$(document).on('change', '#recur_interval_type', function() {
    if ($(this).val() == 'months') {
        $('.subscription_repeat_on_div').removeClass('hide');
    } else {
        $('.subscription_repeat_on_div').addClass('hide');
    }
});

function validate_discount_field() {
    discount_element = $('#discount_amount_modal');
    discount_type_element = $('#discount_type_modal');

    if ($('#add_sell_form').length || $('#edit_sell_form').length) {
        discount_element = $('#discount_amount');
        discount_type_element = $('#discount_type');
    }
    var max_value = parseFloat(discount_element.data('max-discount'));
    if (discount_element.val() != '' && !isNaN(max_value)) {
        if (discount_type_element.val() == 'fixed') {
            var subtotal = get_subtotal();
            //get max discount amount
            max_value = __calculate_amount('percentage', max_value, subtotal)
        }

        discount_element.rules('add', {
            'max-value': max_value,
            messages: {
                'max-value': discount_element.data('max-discount-error_msg'),
            },
        });
    } else {
        discount_element.rules("remove", "max-value");      
    }
    discount_element.trigger('change');
}

$(document).on('change', '#discount_type_modal, #discount_type', function() {
    validate_discount_field();
});

function update_shipping_address(data) {
    if ($('#shipping_address_div').length) {
        var shipping_address = '';
        if (data.supplier_business_name) {
            shipping_address += data.supplier_business_name;
        }
        if (data.name) {
            shipping_address += ',<br>' + data.name;
        }
        if (data.text) {
            shipping_address += ',<br>' + data.text;
        }
        shipping_address += ',<br>' + data.shipping_address ;
        $('#shipping_address_div').html(shipping_address);
    }
    if ($('#billing_address_div').length) {
        var address = [];
        if (data.supplier_business_name) {
            address.push(data.supplier_business_name);
        }
        if (data.name) {
            address.push('<br>' + data.name);
        }
        if (data.text) {
            address.push('<br>' + data.text);
        }
        if (data.address_line_1) {
            address.push('<br>' + data.address_line_1);
        }
        if (data.address_line_2) {
            address.push('<br>' + data.address_line_2);
        }
        if (data.city) {
            address.push('<br>' + data.city);
        }
        if (data.state) {
            address.push(data.state);
        }
        if (data.country) {
            address.push(data.country);
        }
        if (data.zip_code) {
            address.push('<br>' + data.zip_code);
        }
        var billing_address = address.join(', ');
        $('#billing_address_div').html(billing_address);
    }

    if ($('#shipping_custom_field_1').length) {
        let shipping_custom_field_1 = data.shipping_custom_field_details != null ? data.shipping_custom_field_details.shipping_custom_field_1 : '';
        $('#shipping_custom_field_1').val(shipping_custom_field_1);
    }

    if ($('#shipping_custom_field_2').length) {
        let shipping_custom_field_2 = data.shipping_custom_field_details != null ? data.shipping_custom_field_details.shipping_custom_field_2 : '';
        $('#shipping_custom_field_2').val(shipping_custom_field_2);
    }

    if ($('#shipping_custom_field_3').length) {
        let shipping_custom_field_3 = data.shipping_custom_field_details != null ? data.shipping_custom_field_details.shipping_custom_field_3 : '';
        $('#shipping_custom_field_3').val(shipping_custom_field_3);
    }

    if ($('#shipping_custom_field_4').length) {
        let shipping_custom_field_4 = data.shipping_custom_field_details != null ? data.shipping_custom_field_details.shipping_custom_field_4 : '';
        $('#shipping_custom_field_4').val(shipping_custom_field_4);
    }

    if ($('#shipping_custom_field_5').length) {
        let shipping_custom_field_5 = data.shipping_custom_field_details != null ? data.shipping_custom_field_details.shipping_custom_field_5 : '';
        $('#shipping_custom_field_5').val(shipping_custom_field_5);
    }
    
    //update export fields
    if (data.is_export) {
        $('#is_export').prop('checked', true);
        $('div.export_div').show();
        if ($('#export_custom_field_1').length) {
            $('#export_custom_field_1').val(data.export_custom_field_1);
        }
        if ($('#export_custom_field_2').length) {
            $('#export_custom_field_2').val(data.export_custom_field_2);
        }
        if ($('#export_custom_field_3').length) {
            $('#export_custom_field_3').val(data.export_custom_field_3);
        }
        if ($('#export_custom_field_4').length) {
            $('#export_custom_field_4').val(data.export_custom_field_4);
        }
        if ($('#export_custom_field_5').length) {
            $('#export_custom_field_5').val(data.export_custom_field_5);
        }
        if ($('#export_custom_field_6').length) {
            $('#export_custom_field_6').val(data.export_custom_field_6);
        }
    } else {
        $('#export_custom_field_1, #export_custom_field_2, #export_custom_field_3, #export_custom_field_4, #export_custom_field_5, #export_custom_field_6').val('');
        $('#is_export').prop('checked', false);
        $('div.export_div').hide();
    }
    
    $('#shipping_address_modal').val(data.shipping_address);
    $('#shipping_address').val(data.shipping_address);
}

function get_sales_orders() {
    if ($('#sales_order_ids').length) {
        if ($('#sales_order_ids').hasClass('not_loaded')) {
            $('#sales_order_ids').removeClass('not_loaded');
            return false;
        }
        var customer_id = $('select#customer_id').val();
        var location_id = $('input#location_id').val();
        $.ajax({
            url: '/get-sales-orders/' + customer_id + '?location_id=' + location_id,
            dataType: 'json',
            success: function(data) {
                $('#sales_order_ids').select2('destroy').empty().select2({data: data});
                $('table#pos_table tbody').find('tr').each( function(){
                    if (typeof($(this).data('so_id')) !== 'undefined') {
                        $(this).remove();
                    }
                });
                pos_total_row();
            },
        });
    }
}

$("#sales_order_ids").on("select2:select", function (e) {
    var sales_order_id = e.params.data.id;
    var product_row = $('input#product_row_count').val();
    var location_id = $('input#location_id').val();
    $.ajax({
        method: 'GET',
        url: '/get-sales-order-lines',
        async: false,
        data: {
            product_row: product_row,
            sales_order_id: sales_order_id
        },
        dataType: 'json',
        success: function(result) {
            if (result.html) {
                var html = result.html;
                $(html).find('tr').each(function(){
                    $('table#pos_table tbody')
                    .append($(this))
                    .find('input.pos_quantity');
                    
                    var this_row = $('table#pos_table tbody')
                        .find('tr')
                        .last();
                    pos_each_row(this_row);

                    product_row = parseInt(product_row) + 1;

                    //For initial discount if present
                    var line_total = __read_number(this_row.find('input.pos_line_total'));
                    this_row.find('span.pos_line_total_text').text(line_total);

                    //Check if multipler is present then multiply it when a new row is added.
                    if(__getUnitMultiplier(this_row) > 1){
                        this_row.find('select.sub_unit').trigger('change');
                    }

                    round_row_to_iraqi_dinnar(this_row);
                    __currency_convert_recursively(this_row);
                });

                set_so_values(result.sales_order);

                //increment row count
                $('input#product_row_count').val(product_row);
                
                pos_total_row();
            
            } else {
                toastr.error(result.msg);
                $('input#search_product')
                    .focus()
                    .select();
            }
        },
    });
});

function set_so_values(so) {
    $('textarea[name="sale_note"]').val(so.additional_notes);
    if ($('#shipping_details').is(':visible')) {
        $('#shipping_details').val(so.shipping_details);
    }
    $('#shipping_address').val(so.shipping_address);
    $('#delivered_to').val(so.delivered_to);
    $('#shipping_charges').val( __number_f(so.shipping_charges));
    $('#shipping_status').val(so.shipping_status);
    if ($('#shipping_custom_field_1').length) {
        $('#shipping_custom_field_1').val(so.shipping_custom_field_1);
    }
    if ($('#shipping_custom_field_2').length) {
        $('#shipping_custom_field_2').val(so.shipping_custom_field_2);
    }
    if ($('#shipping_custom_field_3').length) {
        $('#shipping_custom_field_3').val(so.shipping_custom_field_3);
    }
    if ($('#shipping_custom_field_4').length) {
        $('#shipping_custom_field_4').val(so.shipping_custom_field_4);
    }
    if ($('#shipping_custom_field_5').length) {
        $('#shipping_custom_field_5').val(so.shipping_custom_field_5);
    }
}

$("#sales_order_ids").on("select2:unselect", function (e) {
    var sales_order_id = e.params.data.id;
    $('table#pos_table tbody').find('tr').each( function(){
        if (typeof($(this).data('so_id')) !== 'undefined' 
            && $(this).data('so_id') == sales_order_id) {
            $(this).remove();
        pos_total_row();
        }
    });
});

$(document).on('click', '#add_expense', function(){
    $.ajax({
        url: '/expenses/create',
        data: { 
            location_id: $('#select_location_id').val()
        },
        dataType: 'html',
        success: function(result) {
            $('#expense_modal').html(result);
            $('#expense_modal').modal('show');
        },
    });
});

$(document).on('shown.bs.modal', '#expense_modal', function(){
    $('#expense_transaction_date').datetimepicker({
        format: moment_date_format + ' ' + moment_time_format,
        ignoreReadonly: true,
    });
    $('#expense_modal .paid_on').datetimepicker({
        format: moment_date_format + ' ' + moment_time_format,
        ignoreReadonly: true,
    });
    $(this).find('.select2').select2();
    $('#add_expense_modal_form').validate();
});

$(document).on('hidden.bs.modal', '#expense_modal', function(){
    $(this).html('');
});

$(document).on('submit', 'form#add_expense_modal_form', function(e) {
    e.preventDefault();
    var data = $(this).serialize();

    $.ajax({
        method: 'POST',
        url: $(this).attr('action'),
        dataType: 'json',
        data: data,
        success: function(result) {
            if (result.success == true) {
                $('#expense_modal').modal('hide');
                toastr.success(result.msg);
            } else {
                toastr.error(result.msg);
            }
        },
    });
});

function get_contact_due(id) {
    $.ajax({
        method: 'get',
        url: /get-contact-due/ + id,
        dataType: 'text',
        success: function(result) {
            if (result != '') {
                $('.contact_due_text').find('span').text(result);
                $('.contact_due_text').removeClass('hide');
            } else {
                $('.contact_due_text').find('span').text('');
                $('.contact_due_text').addClass('hide');
            }
        },
    });
}

function submitQuickContactForm(form) {
    var data = $(form).serialize();
    $.ajax({
        method: 'POST',
        url: $(form).attr('action'),
        dataType: 'json',
        data: data,
        beforeSend: function(xhr) {
            __disable_submit_button($(form).find('button[type="submit"]'));
        },
        success: function(result) {
            if (result.success == true) {
                var name = result.data.name;

                if (result.data.supplier_business_name) {
                    name += result.data.supplier_business_name;
                }
                
                $('select#customer_id').append(
                    $('<option>', { value: result.data.id, text: name })
                );
                $('select#customer_id')
                    .val(result.data.id)
                    .trigger('change');
                $('div.contact_modal').modal('hide');
                update_shipping_address(result.data)
                toastr.success(result.msg);
            } else {
                toastr.error(result.msg);
            }
        },
    });
}

$(document).on('click', '#send_for_sell_return', function(e) {
    var invoice_no = $('#send_for_sell_return_invoice_no').val();

    if (invoice_no) {
        $.ajax({
            method: 'get',
            url: /validate-invoice-to-return/ + encodeURI(invoice_no),
            dataType: 'json',
            success: function(result) {
                if (result.success == true) {
                    window.location = result.redirect_url ;
                } else {
                    toastr.error(result.msg);
                }
            },
        });
    }
})

    $(document).on('click', '#send_for_sercice_staff_replacement', function (e) {
        var invoice_no = $('#send_for_sell_service_staff_invoice_no').val();

        if (invoice_no) {
            $.ajax({
                method: 'get',
                url: /validate-invoice-to-service-staff-replacement/ + encodeURI(invoice_no),
                dataType: 'json',
                success: function (result) {
                    if (result.success == true) {
                        $('#service_staff_replacement').popover('hide');
                        $('#service_staff_modal').html(result.msg);
                        $('#service_staff_modal').modal('show');
                       
                    } else {
                        toastr.error(result.msg);
                    }
                },
            });
        }
    });

    $(document).on('shown.bs.modal', '#service_staff_modal', function () {
        $('#change_service_staff').validate();
    });


    $(document).on('submit', 'form#change_service_staff', function (e) {
        e.preventDefault();
        var data = $(this).serialize();

        $.ajax({
            method: 'POST',
            url: $(this).attr('action'),
            dataType: 'json',
            data: data,
            success: function (result) {
                if (result.success == true) {
                    $('#service_staff_modal').modal('hide');
                    toastr.success(result.msg);
                } else {
                    toastr.error(result.msg);
                }
            },
        });
    });

$(document).on('ifChanged', 'input[name="search_fields[]"]', function(event) {
    var search_fields = [];
    $('input[name="search_fields[]"]:checked').each(function() {
       search_fields.push($(this).val());
    });

    localStorage.setItem('pos_search_fields', search_fields);
});

function set_search_fields() {
    if ($('input[name="search_fields[]"]').length == 0) {
        return false;
    }

    var pos_search_fields = localStorage.getItem('pos_search_fields');

    if (pos_search_fields === null) {
        pos_search_fields = ['name', 'sku', 'lot'];
    }

    $('input[name="search_fields[]"]').each(function() {
        if (pos_search_fields.indexOf($(this).val()) >= 0) {
            $(this).iCheck('check');
        } else {
            $(this).iCheck('uncheck');
        }
    });
}

$(document).on('click', '#show_service_staff_availability', function(){
    loadServiceStaffAvailability();
})
$(document).on('click', '#refresh_service_staff_availability_status', function(){
    loadServiceStaffAvailability(false);
})
$(document).on('click', 'button.pause_resume_timer', function(e){
    $('.view_modal').find('.overlay').removeClass('hide');
    $.ajax({
        method: 'get',
        url: $(this).attr('data-href'),
        dataType: 'json',
        success: function(result) {
            loadServiceStaffAvailability(false);
        },
    });
})

$(document).on('click', '.mark_as_available', function(e){
    e.preventDefault()
    $('.view_modal').find('.overlay').removeClass('hide');
    $.ajax({
        method: 'get',
        url: $(this).attr('href'),
        dataType: 'json',
        success: function(result) {
            loadServiceStaffAvailability(false);
        },
    });
})
var service_staff_availability_interval = null;

function loadServiceStaffAvailability(show = true) {
    var location_id = $('[name="location_id"]').val();
    $.ajax({
        method: 'get',
        url: $('#show_service_staff_availability').attr('data-href'),
        dataType: 'html',
        data: {location_id: location_id},
        success: function(result) {
            $('.view_modal').html(result);
            if (show) {
                $('.view_modal').modal('show')

                //auto refresh service staff availabilty if modal is open
                service_staff_availability_interval = setInterval(function () {
                    loadServiceStaffAvailability(false);
                }, 60000);
            }
        },
    });
}

$(document).on('hidden.bs.modal', '.view_modal', function(){
    if (service_staff_availability_interval !== null) {
        clearInterval(service_staff_availability_interval);
    }
    service_staff_availability_interval = null;
});


$(document).on('change', '#res_waiter_id', function(e){
    var is_enable = $(this).find('option:selected').data('is_enable');

    if(is_enable){
        swal({
            text: LANG.enter_pin_here,
            buttons: true,
            dangerMode: true,
            content: {
                element: "input",
                attributes: {
                    placeholder: LANG.enter_pin_here,
                    type: "password",
                },
            },
        })
        .then((inputValue) => {
            if (inputValue !== null) {
                    $.ajax({
                        method: 'get',
                        url: '/modules/data/check-staff-pin',
                        dataType: 'json',
                        data: {
                        service_staff_pin: inputValue,
                        user_id : $("#res_waiter_id").val(),
                        },
                        success: (result) => {

                            if (result == false) {
                                toastr.error(LANG.authentication_failed);
                                $("#res_waiter_id").val('');
                            } else {
                                // AJAX request succeeded, resolve
                                toastr.success(LANG.authentication_successfull);
                            }
                        },
                    });
            } else {
                // Handle the "Cancel" action
                $("#res_waiter_id").val('');
            }
        });
        
    }
})

// update serial number of product item
function update_serial_no(){
    $('.product_row').each(function (index) {
        // Add the serial number to the first <td> of each row (index + 1 to start from 1)
        if ($(this).find('td:first').hasClass('serial_no')) {
            $(this).find('td:first').text(index + 1);
        }
    });
}


/**
 * Saves the serialized form data from #add_pos_sell_form into LocalStorage.
 */
function saveFormDataToLocalStorage() {


    // Check if global_is_clear_local_storage is true and reset it to false if so
    if(global_is_clear_local_storage){
        localStorage.setItem("pos_form_data_array", JSON.stringify([]));
        global_is_clear_local_storage = false;
        return false; // Exit the function early if global_is_clear_local_storage was true
    }

    // var storedArrayData = JSON.parse(localStorage.getItem("pos_form_data_array"));

    // console.log("All data afer clear:", storedArrayData);

    let form = $('form#add_pos_sell_form'); // Select the form by ID
    // Check if the form exists in the DOM
    if (form.length === 0) {
        console.error("Error: Form #add_pos_sell_form not found.");
        return;
    }
    // Serialize form data into an array of objects: [{name: 'input_name', value: 'input_value'}, ...]
    let formArray = form.serializeArray();

    // Find if "price_total" already exists in the array
    let priceIndex = formArray.findIndex(item => item.name === "price_total");

    if (priceIndex !== -1) {
        // If exists, update the value
        formArray[priceIndex].value = get_subtotal();
    } else {
        // If not exists, push new entry
        formArray.push({ name: "price_total", value: get_subtotal() });
    }

    // Find if "order_tax" already exists in the array
    let textIndex = formArray.findIndex(item => item.name === "order_tax");

    if (priceIndex !== -1) {
        // If exists, update the value
        formArray[textIndex].value = $("#order_tax").text().trim();
    } else {
        // If not exists, push new entry
        formArray.push({ name: "order_tax", value: $("#order_tax").text().trim()});
    }

    // Find if "shipping_charges_amount" already exists in the array
    let shipping_charges_amount = formArray.findIndex(item => item.name === "shipping_charges_amount");

    if (priceIndex !== -1) {
        // If exists, update the value
        formArray[shipping_charges_amount].value = $("#shipping_charges_amount").text().trim();
    } else {
        // If not exists, push new entry
        formArray.push({ name: "shipping_charges_amount", value: $("#shipping_charges_amount").text().trim()});
    }

    // Find if "total_paying_input" already exists in the array
    let total_paying_input = formArray.findIndex(item => item.name === "total_paying_input");
    
    if (priceIndex !== -1) {
        // If exists, update the value
        formArray[total_paying_input].value = $("#total_paying_input").val();
    } else {
        // If not exists, push new entry
        formArray.push({ name: "total_paying_input", value: $("#total_paying_input").val()});
    }

    // Find if "change_return" already exists in the array
    let change_return = formArray.findIndex(item => item.name === "change_return");
    if (priceIndex !== -1) {
        // If exists, update the value
        formArray[change_return].value = $("#change_return").val();
    } else {
        // If not exists, push new entry
        formArray.push({ name: "change_return", value: $("#change_return").val()});
    }
     // Find if "in_balance_due" already exists in the array
     let in_balance_due = formArray.findIndex(item => item.name === "in_balance_due");
     if (priceIndex !== -1) {
         // If exists, update the value
         formArray[in_balance_due].value = $("#in_balance_due").val();
     } else {
         // If not exists, push new entry
         formArray.push({ name: "in_balance_due", value: $("#in_balance_due").val()});
     }
    // Store serialized data in LocalStorage as a JSON string
    localStorage.setItem("pos_form_data_array", JSON.stringify(formArray));

    // console.log("Form data successfully saved to LocalStorage.");
}
