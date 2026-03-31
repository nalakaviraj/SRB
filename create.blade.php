@extends('layouts.app')
@section('title', __('product.add_new_product'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1 class="tw-text-xl md:tw-text-3xl tw-font-bold tw-text-black">@lang('product.add_new_product')</h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">
    @php
    $form_class = empty($duplicate_product) ? 'create' : '';
    $is_image_required = !empty($common_settings['is_product_image_required']);
    @endphp
    {!! Form::open(['url' => action([\App\Http\Controllers\ProductController::class, 'store']), 'method' => 'post',
    'id' => 'product_add_form','class' => 'product_form ' . $form_class, 'files' => true ]) !!}
    @component('components.widget', ['class' => 'box-primary'])
    <div class="row product-secondary-fields">
        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('name', __('product.product_name') . ':*') !!}
                {!! Form::text('name', !empty($duplicate_product->name) ? $duplicate_product->name : null, ['class' => 'form-control', 'required',
                'placeholder' => __('product.product_name')]); !!}
            </div>
        </div>

        <div class="clearfix"></div>
        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('unit_id', __('product.unit') . ':*') !!}
                <div class="input-group">
                {!! Form::select('unit_id', $units, !empty($duplicate_product->unit_id) ? $duplicate_product->unit_id : $default_unit_id, ['class' => 'form-control select2', 'required']); !!}
                    <span class="input-group-btn">
                        <button type="button" @if(!auth()->user()->can('unit.create')) disabled @endif class="btn btn-default bg-white btn-flat btn-modal" data-href="{{action([\App\Http\Controllers\UnitController::class, 'create'], ['quick_add' => true])}}" title="@lang('unit.add_unit')" data-container=".view_modal"><i class="fa fa-plus-circle text-primary fa-lg"></i></button>
                    </span>
                </div>
            </div>
        </div>

        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('current_quantity', 'Current Quantity:') !!}
                {!! Form::text('current_quantity', null, ['class' => 'form-control input_number', 'id' => 'current_quantity', 'placeholder' => 'Current Quantity']); !!}
            </div>
        </div>

        <div class="col-sm-4 @if(!session('business.enable_sub_units')) hide @endif">
            <div class="form-group">
                {!! Form::label('sub_unit_ids', __('lang_v1.related_sub_units') . ':') !!} @show_tooltip(__('lang_v1.sub_units_tooltip'))

                {!! Form::select('sub_unit_ids[]', [], !empty($duplicate_product->sub_unit_ids) ? $duplicate_product->sub_unit_ids : null, ['class' => 'form-control select2', 'multiple', 'id' => 'sub_unit_ids']); !!}
            </div>
        </div>
        @if(!empty($common_settings['enable_secondary_unit']))
        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('secondary_unit_id', __('lang_v1.secondary_unit') . ':') !!} @show_tooltip(__('lang_v1.secondary_unit_help'))
                {!! Form::select('secondary_unit_id', $units, !empty($duplicate_product->secondary_unit_id) ? $duplicate_product->secondary_unit_id : null, ['class' => 'form-control select2']); !!}
            </div>
        </div>
        @endif

        <div class="col-sm-4 hide @if(!session('business.enable_brand')) hide @endif">
            <div class="form-group">
                {!! Form::label('brand_id', __('product.brand') . ':') !!}
                <div class="input-group">
                    {!! Form::select('brand_id', $brands, !empty($duplicate_product->brand_id) ? $duplicate_product->brand_id : null, ['placeholder' => __('messages.please_select'), 'class' => 'form-control select2']); !!}
                    <span class="input-group-btn">
                        <button type="button" @if(!auth()->user()->can('brand.create')) disabled @endif class="btn btn-default bg-white btn-flat btn-modal" data-href="{{action([\App\Http\Controllers\BrandController::class, 'create'], ['quick_add' => true])}}" title="@lang('brand.add_brand')" data-container=".view_modal"><i class="fa fa-plus-circle text-primary fa-lg"></i></button>
                    </span>
                </div>
            </div>
        </div>
        <div class="col-sm-4 hide @if(!session('business.enable_category')) hide @endif">
            <div class="form-group">
                {!! Form::label('category_id', __('product.category') . ':') !!}
                {!! Form::select('category_id', $categories, !empty($duplicate_product->category_id) ? $duplicate_product->category_id : null, ['placeholder' => __('messages.please_select'), 'class' => 'form-control select2']); !!}
            </div>
        </div>

        <div class="col-sm-4 hide @if(!(session('business.enable_category') && session('business.enable_sub_category'))) hide @endif">
            <div class="form-group">
                {!! Form::label('sub_category_id', __('product.sub_category') . ':') !!}
                {!! Form::select('sub_category_id', $sub_categories, !empty($duplicate_product->sub_category_id) ? $duplicate_product->sub_category_id : null, ['placeholder' => __('messages.please_select'), 'class' => 'form-control select2']); !!}
            </div>
        </div>

        @php
        $default_location = null;
        if (count($business_locations) >= 1) {
        $default_location = array_key_first($business_locations->toArray());
        }
        @endphp
        <div class="clearfix"></div>

        @if(!empty($common_settings['enable_product_warranty']))
        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('warranty_id', __('lang_v1.warranty') . ':') !!}
                {!! Form::select('warranty_id', $warranties, null, ['class' => 'form-control select2', 'placeholder' => __('messages.please_select')]); !!}
            </div>
        </div>
        @endif
        <!-- include module fields -->
        @if(!empty($pos_module_data))
        @foreach($pos_module_data as $key => $value)
        @if(!empty($value['view_path']))
        @includeIf($value['view_path'], ['view_data' => $value['view_data']])
        @endif
        @endforeach
        @endif
        <div class="clearfix"></div>
        <div class="col-sm-8 mb-5 hide">
            <div class="form-group">
                <div class="row">
                    <div class="col-sm-8 product-description-label">
                        {!! Form::label('product_description', __('lang_v1.product_description') . ':') !!}
                    </div> 
                </div>
                {!! Form::textarea('product_description', !empty($duplicate_product->product_description) ? $duplicate_product->product_description : null, ['class' => 'form-control']); !!}
            </div>
        </div>
    </div>
    <div class="col-sm-4 hide">
        <div class="form-group">
            {!! Form::label('product_brochure', __('lang_v1.product_brochure') . ':') !!}
            {!! Form::file('product_brochure', ['id' => 'product_brochure', 'accept' => implode(',', array_keys(config('constants.document_upload_mimes_types')))]); !!}
            <small>
                <p class="help-block">
                    @lang('purchase.max_file_size', ['size' => (config('constants.document_size_limit') / 1000000)])
                    @includeIf('components.document_help_text')
                </p>
            </small>
        </div>
    </div>
    @endcomponent

    @component('components.widget', ['class' => 'box-primary'])
    <div class="row">
        @if(session('business.enable_product_expiry'))

        @if(session('business.expiry_type') == 'add_expiry')
        @php
        $expiry_period = 12;
        $hide = true;
        @endphp
        @else
        @php
        $expiry_period = null;
        $hide = false;
        @endphp
        @endif
        <div class="col-sm-4 @if($hide) hide @endif">
            <div class="form-group">
                <div class="multi-input">
                    {!! Form::label('expiry_period', __('product.expires_in') . ':') !!}<br>
                    {!! Form::text('expiry_period', !empty($duplicate_product->expiry_period) ? @num_format($duplicate_product->expiry_period) : $expiry_period, ['class' => 'form-control pull-left input_number',
                    'placeholder' => __('product.expiry_period'), 'style' => 'width:60%;']); !!}
                    {!! Form::select('expiry_period_type', ['months'=>__('product.months'), 'days'=>__('product.days'), '' =>__('product.not_applicable') ], !empty($duplicate_product->expiry_period_type) ? $duplicate_product->expiry_period_type : 'months', ['class' => 'form-control select2 pull-left', 'style' => 'width:40%;', 'id' => 'expiry_period_type']); !!}
                </div>
            </div>
        </div>
        @endif

        <div class="col-sm-4 hide">
            <div class="form-group">
                <br>
                <label>
                    {!! Form::checkbox('enable_sr_no', 1, !(empty($duplicate_product)) ? $duplicate_product->enable_sr_no : false, ['class' => 'input-icheck']); !!} <strong>@lang('lang_v1.enable_imei_or_sr_no')</strong>
                </label> @show_tooltip(__('lang_v1.tooltip_sr_no'))
            </div>
        </div>

        <div class="col-sm-4 hide">
            <div class="form-group">
                <br>
                <label>
                    {!! Form::checkbox('not_for_selling', 1, !(empty($duplicate_product)) ? $duplicate_product->not_for_selling : false, ['class' => 'input-icheck']); !!} <strong>@lang('lang_v1.not_for_selling')</strong>
                </label> @show_tooltip(__('lang_v1.tooltip_not_for_selling'))
            </div>
        </div>

        <div class="clearfix"></div>

        <!-- Rack, Row & position number -->
        @if(session('business.enable_racks') || session('business.enable_row') || session('business.enable_position'))
        <div class="col-md-12">
            <h4>@lang('lang_v1.rack_details'):
                @show_tooltip(__('lang_v1.tooltip_rack_details'))
            </h4>
        </div>
        @foreach($business_locations as $id => $location)
        <div class="col-sm-3">
            <div class="form-group">
                {!! Form::label('rack_' . $id, $location . ':') !!}

                @if(session('business.enable_racks'))
                {!! Form::text('product_racks[' . $id . '][rack]', !empty($rack_details[$id]['rack']) ? $rack_details[$id]['rack'] : null, ['class' => 'form-control', 'id' => 'rack_' . $id,
                'placeholder' => __('lang_v1.rack')]); !!}
                @endif

                @if(session('business.enable_row'))
                {!! Form::text('product_racks[' . $id . '][row]', !empty($rack_details[$id]['row']) ? $rack_details[$id]['row'] : null, ['class' => 'form-control', 'placeholder' => __('lang_v1.row')]); !!}
                @endif

                @if(session('business.enable_position'))
                {!! Form::text('product_racks[' . $id . '][position]', !empty($rack_details[$id]['position']) ? $rack_details[$id]['position'] : null, ['class' => 'form-control', 'placeholder' => __('lang_v1.position')]); !!}
                @endif
            </div>
        </div>
        @endforeach
        @endif

        @php
        $custom_labels = json_decode(session('business.custom_labels'), true);
        $product_custom_fields = !empty($custom_labels['product']) ? $custom_labels['product'] : [];
        $product_cf_details = !empty($custom_labels['product_cf_details']) ? $custom_labels['product_cf_details'] : [];

        @endphp
        <!--custom fields-->
        <div class="clearfix"></div>

        @foreach($product_custom_fields as $index => $cf)
            @if(!empty($cf))
                @php
                    $db_field_name = 'product_custom_field' . $loop->iteration;
                    $cf_type = !empty($product_cf_details[$loop->iteration]['type']) ? $product_cf_details[$loop->iteration]['type'] : 'text';
                    $dropdown = !empty($product_cf_details[$loop->iteration]['dropdown_options']) ? explode(PHP_EOL, $product_cf_details[$loop->iteration]['dropdown_options']) : [];
                @endphp

                <div class="col-sm-3">
                    <div class="form-group">
                        {!! Form::label($db_field_name, $cf . ':') !!}

                        @if(in_array($cf_type, ['text', 'date']))
                        
                            <input type="{{$cf_type}}" name="{{$db_field_name}}" id="{{$db_field_name}}" value="{{!empty($duplicate_product->$db_field_name) ? $duplicate_product->$db_field_name : null}}" class="form-control" placeholder="{{$cf}}">

                        @elseif($cf_type == 'dropdown')
                            <!-- {!! Form::select($db_field_name, $dropdown, !empty($duplicate_product->$db_field_name) ? $duplicate_product->$db_field_name : null, ['placeholder' => $cf, 'class' => 'form-control select2']); !!} -->
                            <select name="{{ $db_field_name }}" id="{{ $db_field_name }}" class="form-control select2">
                                <option value="">{{ $cf }}</option>
                                @foreach($dropdown as $option)
                                    <option value="{{ $option }}" @if(!empty($duplicate_product->$db_field_name) && $option == $duplicate_product->$db_field_name) selected @endif>
                                        {{ $option }}
                                    </option>
                                @endforeach
                            </select>
                        @endif
                    </div>
                </div>
            @endif
        @endforeach

        <!--custom fields-->
        <div class="clearfix"></div>
        @include('layouts.partials.module_form_part')
    </div>
    @endcomponent

    @component('components.widget', ['class' => 'box-primary'])
    <div class="row">

        <div class="col-sm-4 hide @if(!session('business.enable_price_tax')) hide @endif">
            <div class="form-group">
                {!! Form::label('tax', __('product.applicable_tax') . ':') !!}
                {!! Form::select('tax', $taxes, !empty($duplicate_product->tax) ? $duplicate_product->tax : null, ['placeholder' => __('messages.please_select'), 'class' => 'form-control select2'], $tax_attributes); !!}
            </div>
        </div>

        <div class="col-sm-4 hide @if(!session('business.enable_price_tax')) hide @endif">
            <div class="form-group">
                {!! Form::label('tax_type', __('product.selling_price_tax_type') . ':*') !!}
                {!! Form::select('tax_type', ['inclusive' => __('product.inclusive'), 'exclusive' => __('product.exclusive')], !empty($duplicate_product->tax_type) ? $duplicate_product->tax_type : 'exclusive',
                ['class' => 'form-control select2', 'required']); !!}
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-sm-4 hide">
            <div class="form-group">
                {!! Form::label('type', __('product.product_type') . ':*') !!} @show_tooltip(__('tooltip.product_type'))
                {!! Form::select('type', $product_types, !empty($duplicate_product->type) ? $duplicate_product->type : 'single', ['class' => 'form-control select2',
                'required', 'data-action' => !empty($duplicate_product) ? 'duplicate' : 'add', 'data-product_id' => !empty($duplicate_product) ? $duplicate_product->id : '0']); !!}
            </div>
        </div>

        <div class="form-group col-sm-12" id="product_form_part">
            @include('product.partials.single_product_form_part', ['profit_percent' => $default_profit_percent])
        </div>

        <input type="hidden" id="variation_counter" value="1">
        <input type="hidden" id="default_profit_percent" value="{{ $default_profit_percent }}">

    </div>
    @endcomponent

    @component('components.widget', ['class' => 'box-primary'])
    <div class="row">
        <div class="col-sm-12">
            <small class="text-muted">@lang('lang_v1.optional')</small>
        </div>

        <div class="col-sm-4 hide">
            <div class="form-group">
                {!! Form::label('product_locations', __('business.business_locations') . ':') !!} @show_tooltip(__('lang_v1.product_location_help'))
                {!! Form::select('product_locations[]', $business_locations, $default_location, ['class' => 'form-control select2', 'multiple', 'id' => 'product_locations']); !!}
            </div>
        </div>

        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('sku', __('product.sku') . ':') !!} @show_tooltip(__('tooltip.sku'))
                {!! Form::text('sku', null, ['class' => 'form-control',
                'placeholder' => __('product.sku')]); !!}
            </div>
        </div>
        <div class="col-sm-4 hide">
            <div class="form-group">
                {!! Form::label('barcode_type', __('product.barcode_type') . ':*') !!}
                {!! Form::select('barcode_type', $barcode_types, !empty($duplicate_product->barcode_type) ? $duplicate_product->barcode_type : $barcode_default, ['class' => 'form-control select2', 'required']); !!}
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-sm-4">
            <div class="form-group">
                <br>
                <label>
                    {!! Form::checkbox('enable_stock', 1, !empty($duplicate_product) ? $duplicate_product->enable_stock : true, ['class' => 'input-icheck', 'id' => 'enable_stock']); !!} <strong>@lang('product.manage_stock')</strong>
                </label>@show_tooltip(__('tooltip.enable_stock')) <p class="help-block"><i>@lang('product.enable_stock_help')</i></p>
            </div>
        </div>
        <div class="col-sm-4 @if(!empty($duplicate_product) && $duplicate_product->enable_stock == 0) hide @endif" id="alert_quantity_div">
            <div class="form-group">
                {!! Form::label('alert_quantity', __('product.alert_quantity') . ':') !!} @show_tooltip(__('tooltip.alert_quantity'))
                {!! Form::text('alert_quantity', !empty($duplicate_product->alert_quantity) ? @format_quantity($duplicate_product->alert_quantity) : null , ['class' => 'form-control input_number',
                'placeholder' => __('product.alert_quantity'), 'min' => '0']); !!}
            </div>
        </div>

        <div class="col-sm-4 hide">
            <div class="form-group">
                {!! Form::label('weight', __('lang_v1.weight') . ':') !!}
                {!! Form::text('weight', !empty($duplicate_product->weight) ? $duplicate_product->weight : null, ['class' => 'form-control', 'placeholder' => __('lang_v1.weight')]); !!}
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="col-sm-4 hide">
            <div class="form-group">
                {!! Form::label('preparation_time_in_minutes', __('lang_v1.preparation_time_in_minutes') . ':') !!}
                {!! Form::number('preparation_time_in_minutes', !empty($duplicate_product->preparation_time_in_minutes) ? $duplicate_product->preparation_time_in_minutes : null, ['class' => 'form-control', 'placeholder' => __('lang_v1.preparation_time_in_minutes')]); !!}
            </div>
        </div>

        <div class="col-sm-4">
            <div class="form-group">
                <div class="row">
                    <div class="col-sm-6 image-label">
                    {!! Form::label('image', __('lang_v1.product_image') . ':') !!}
                    </div>
                </div>
                {!! Form::file('image', ['id' => 'upload_image', 'accept' => 'image/*',
                'required' => $is_image_required, 'class' => 'upload-element']); !!}
                <small>
                    <p class="help-block">@lang('purchase.max_file_size', ['size' => (config('constants.document_size_limit') / 1000000)]) <br> @lang('lang_v1.aspect_ratio_should_be_1_1')</p>
                </small>
            </div>
        </div>

        <div class="col-sm-4">
            <div class="form-group">
                {!! Form::label('variation_images', __('lang_v1.product_image') . ':') !!}
                {!! Form::file('variation_images[]', ['class' => 'variation_images',
                    'accept' => 'image/*', 'multiple']); !!}
                <small><p class="help-block">@lang('purchase.max_file_size', ['size' => (config('constants.document_size_limit') / 1000000)]) <br> @lang('lang_v1.aspect_ratio_should_be_1_1')</p></small>
            </div>
        </div>

        {!! Form::hidden('opening_stock[0][quantity]', 0, ['id' => 'opening_stock_qty']) !!}
        {!! Form::hidden('opening_stock[0][purchase_price]', 0, ['id' => 'opening_stock_purchase_price']) !!}
        {!! Form::hidden('opening_stock[0][exp_date]', null, ['id' => 'opening_stock_exp_date']) !!}
        {!! Form::hidden('opening_stock[0][lot_number]', null, ['id' => 'opening_stock_lot_number']) !!}
    </div>
    @endcomponent

    <div class="row">
        <div class="col-sm-12">
            <input type="hidden" name="submit_type" id="submit_type">
            <div class="text-center">
                <div class="btn-group">
                    <button type="submit" value="submit" class="tw-dw-btn tw-dw-btn-primary tw-dw-btn-lg tw-text-white submit_product_form">@lang('messages.save')</button>
                    <button type="submit" id="print_label_button" value="save_n_print_label" class="tw-dw-btn tw-dw-btn-lg bg-purple submit_product_form">@lang('barcode.print_labels')</button>
                    <button type="submit" value="save_n_add_another" class="tw-dw-btn tw-dw-btn-lg bg-maroon submit_product_form">@lang('lang_v1.save_n_add_another')</button>
                </div>

            </div>
        </div>
    </div>
    {!! Form::close() !!}

</section>
<!-- /.content -->

<div class="modal fade" id="print_label_modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">@lang('barcode.print_labels')</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="print_label_qty">@lang('barcode.no_of_labels')</label>
                    <input type="number" class="form-control" id="print_label_qty" min="1" value="1">
                    <input type="hidden" id="print_label_product_id">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="tw-dw-btn tw-dw-btn-secondary" data-dismiss="modal">@lang('messages.cancel')</button>
                <button type="button" class="tw-dw-btn tw-dw-btn-primary tw-text-white" id="print_label_confirm">@lang('barcode.print_labels')</button>
            </div>
        </div>
    </div>
</div>

@endsection

@section('javascript')

<script type="text/javascript">
    window.__simple_product_form = true;
</script>
<script src="{{ asset('js/qz-tray.js?v=' . $asset_v) }}"></script>
<script src="{{ asset('js/qz-helper.js?v=' . $asset_v) }}"></script>
<script src="{{ asset('js/product.js?v=' . $asset_v) }}"></script>

<script type="text/javascript">
    var printLabelsFlag = "{{ request()->get('print_labels') ? '1' : '' }}";
    var printLabelProductId = "{{ request()->get('product_id') ?? '' }}";
    var quickLabelDataUrl = "{{ action([\App\Http\Controllers\LabelsController::class, 'quickPrintData']) }}";

    $(document).ready(function() {
        __page_leave_confirmation('#product_add_form');
        onScan.attachTo(document, {
            suffixKeyCodes: [13], // enter-key expected at the end of a scan
            reactToPaste: true, // Compatibility to built-in scanners in paste-mode (as opposed to keyboard-mode)
            onScan: function(sCode, iQty) {
                $('input#sku').val(sCode);
            },
            onScanError: function(oDebug) {
                console.log(oDebug);
            },
            minLength: 2,
            ignoreIfFocusOn: ['input', '.form-control']
            // onKeyDetect: function(iKeyCode){ // output all potentially relevant key events - great for debugging!
            //     console.log('Pressed: ' + iKeyCode);
            // }
        });

        function getOpeningStockLocationId() {
            var locations = $('#product_locations').val();
            if (locations && locations.length) {
                return locations[0];
            }
            return null;
        }

        function syncOpeningStockNames() {
            var location_id = getOpeningStockLocationId();
            if (!location_id) {
                return;
            }
            $('#opening_stock_qty').attr('name', 'opening_stock[' + location_id + '][quantity]');
            $('#opening_stock_purchase_price').attr('name', 'opening_stock[' + location_id + '][purchase_price]');
            $('#opening_stock_exp_date').attr('name', 'opening_stock[' + location_id + '][exp_date]');
            $('#opening_stock_lot_number').attr('name', 'opening_stock[' + location_id + '][lot_number]');
        }

        function readNumber($el) {
            if (typeof __read_number === 'function') {
                return __read_number($el);
            }
            var raw = $el.val();
            var parsed = parseFloat(raw);
            return isNaN(parsed) ? 0 : parsed;
        }

        function syncOpeningStockValues() {
            var qty = readNumber($('#current_quantity'));
            if (qty < 0) {
                qty = 0;
            }
            $('#opening_stock_qty').val(qty);

            var cost = readNumber($('#single_dpp'));
            if (cost < 0) {
                cost = 0;
            }
            $('#opening_stock_purchase_price').val(cost);
        }

        function toggleCurrentQuantity() {
            var enabled = $('#enable_stock').is(':checked');
            $('#current_quantity').prop('disabled', !enabled);
            if (!enabled) {
                $('#current_quantity').val('');
            }
            syncOpeningStockValues();
        }

        $('#current_quantity').on('input', syncOpeningStockValues);
        $('#single_dpp').on('input', syncOpeningStockValues);
        $('#product_locations').on('change', syncOpeningStockNames);
        $('#enable_stock').on('change', toggleCurrentQuantity);

        syncOpeningStockNames();
        toggleCurrentQuantity();
        syncOpeningStockValues();

        if (printLabelsFlag && printLabelProductId) {
            $('#print_label_product_id').val(printLabelProductId);
            $('#print_label_modal').modal('show');
        }

        $('#print_label_confirm').on('click', function() {
            if (typeof window.qzHelper === 'undefined') {
                if (typeof toastr !== 'undefined') {
                    toastr.error('QZ Tray not loaded. Please install QZ Tray and refresh.');
                }
                return;
            }
            var qty = parseInt($('#print_label_qty').val(), 10);
            if (!qty || qty < 1) {
                qty = 1;
            }
            var productId = $('#print_label_product_id').val();
            if (!productId) {
                return;
            }
            $.ajax({
                method: 'GET',
                url: quickLabelDataUrl,
                dataType: 'json',
                data: { product_id: productId }
            }).done(function(result) {
                if (!result || !result.success || !result.data) {
                    if (typeof toastr !== 'undefined') {
                        toastr.error('Failed to prepare labels.');
                    }
                    return;
                }
                var data = {
                    'barcode_setting': result.data.barcode_setting,
                    'print[name]': 1,
                    'print[name_size]': 15,
                    'print[variations]': 1,
                    'print[variations_size]': 17,
                    'print[price]': 1,
                    'print[price_size]': 17,
                    'print[price_type]': 'inclusive',
                    'print[business_name]': 1,
                    'print[business_name_size]': 20,
                    'print[packing_date]': 1,
                    'print[packing_date_size]': 12,
                    'print[lot_number]': 1,
                    'print[lot_number_size]': 12,
                    'print[exp_date]': 1,
                    'print[exp_date_size]': 12,
                    'products[0][product_id]': result.data.product_id,
                    'products[0][variation_id]': result.data.variation_id,
                    'products[0][quantity]': qty
                };
                window.qzHelper.printLabelsFromData(data)
                    .then(function() {
                        if (typeof toastr !== 'undefined') {
                            toastr.success('Label sent to printer.');
                        }
                        $('#print_label_modal').modal('hide');
                    })
                    .catch(function(err) {
                        console.error(err);
                        if (typeof toastr !== 'undefined') {
                            toastr.error('Failed to print labels.');
                        }
                    });
            }).fail(function() {
                if (typeof toastr !== 'undefined') {
                    toastr.error('Failed to prepare labels.');
                }
            });
        });
    });
</script>
@endsection
