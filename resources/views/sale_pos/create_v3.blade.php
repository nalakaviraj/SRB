@extends('layouts.app')

@section('title', __('sale.pos_sale'))

@section('content')
    <section class="content no-print pos-v3">
        <input type="hidden" id="amount_rounding_method" value="{{ $pos_settings['amount_rounding_method'] ?? '' }}">
        @if (!empty($pos_settings['allow_overselling']))
            <input type="hidden" id="is_overselling_allowed">
        @endif
        @if (session('business.enable_rp') == 1)
            <input type="hidden" id="reward_point_enabled">
        @endif
        @php
            $is_discount_enabled = $pos_settings['disable_discount'] != 1 ? true : false;
            $is_rp_enabled = session('business.enable_rp') == 1 ? true : false;
        @endphp
        {!! Form::open([
            'url' => action([\App\Http\Controllers\SellPosController::class, 'store']),
            'method' => 'post',
            'id' => 'add_pos_sell_form',
        ]) !!}
        <div class="pos-v3__shell">
            <div class="pos-v3__hero">
                <div class="pos-v3__title">
                    <div class="pos-v3__kicker">POS</div>
                    <h1>@lang('sale.pos_sale')</h1>
                    <div class="pos-v3__subtitle">Scan, search, and charge in seconds.</div>
                </div>
                <div class="pos-v3__meta">
                    <div class="pos-v3__pill">
                        <span>@lang('sale.location'):</span>
                        <strong>{{ $default_location->name ?? '-' }}</strong>
                    </div>
                    <div class="pos-v3__pill">
                        <span>Now:</span>
                        <strong>{{ @format_datetime('now') }}</strong>
                    </div>
                </div>
            </div>

            <div class="pos-v3__layout">
                <main class="pos-v3__main">
                    <div class="pos-v3__card pos-v3__card--delay-1 pos-cart-panel">
                        <div class="pos-v3__card__head">
                            <h2>Checkout</h2>
                            <span>Scan or search products</span>
                        </div>

                        {!! Form::hidden('location_id', $default_location->id ?? null, [
                            'id' => 'location_id',
                            'data-receipt_printer_type' => !empty($default_location->receipt_printer_type)
                                ? $default_location->receipt_printer_type
                                : 'browser',
                            'data-default_payment_accounts' => $default_location->default_payment_accounts ?? '',
                        ]) !!}
                        {!! Form::hidden('sub_type', isset($sub_type) ? $sub_type : null) !!}
                        <input type="hidden" id="item_addition_method"
                            value="{{ $business_details->item_addition_method }}">

                        @include('sale_pos.partials.pos_form')
                    </div>

                    <div class="pos-v3__card pos-v3__card--delay-2">
                        <div class="pos-v3__card__head">
                            <h2>Totals</h2>
                            <span>Discounts, taxes, and summary</span>
                        </div>
                        @include('sale_pos.partials.pos_form_totals')
                    </div>
                </main>

                <aside class="pos-v3__side">
                    @if (empty($pos_settings['hide_product_suggestion']) && !isMobile())
                        <div class="pos-v3__card pos-v3__card--delay-3 pos-suggestion-panel">
                            <div class="pos-v3__card__head">
                                <h2>Catalog</h2>
                                <span>Tap to add</span>
                            </div>
                            @include('sale_pos.partials.pos_sidebar')
                        </div>
                    @endif
                </aside>
            </div>

            <div class="pos-v3__dock">
                @include('sale_pos.partials.pos_form_actions')
            </div>
        </div>

        @include('sale_pos.partials.payment_modal')

        @if (empty($pos_settings['disable_suspend']))
            @include('sale_pos.partials.suspend_note_modal')
        @endif

        @if (empty($pos_settings['disable_recurring_invoice']))
            @include('sale_pos.partials.recurring_invoice_modal')
        @endif

        {!! Form::close() !!}
    </section>

    <section class="invoice print_section" id="receipt_section">
    </section>
    <div class="modal fade contact_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
        @include('contact.create', ['quick_add' => true])
    </div>
    @if (empty($pos_settings['hide_product_suggestion']) && isMobile())
        @include('sale_pos.partials.mobile_product_suggestions')
    @endif
    <div class="modal fade register_details_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade close_register_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade quick_add_product_modal" tabindex="-1" role="dialog" aria-labelledby="modalTitle"></div>
    <div class="modal fade edit_product_modal" tabindex="-1" role="dialog" aria-labelledby="modalTitle"></div>

    <div class="modal fade" id="expense_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
    </div>

    @include('sale_pos.partials.configure_search_modal')

    @include('sale_pos.partials.recent_transactions_modal')

    @include('sale_pos.partials.weighing_scale_modal')
@stop

@section('css')
    <!-- include module css -->
    @if (!empty($pos_module_data))
        @foreach ($pos_module_data as $key => $value)
            @if (!empty($value['module_css_path']))
                @includeIf($value['module_css_path'])
            @endif
        @endforeach
    @endif
@stop

@push('pos_css')
    <link rel="stylesheet" href="{{ asset('css/pos_v3.css?v=' . $asset_v) }}">
@endpush

@section('javascript')
    <script type="text/javascript">
        window.__pos_can_edit_product = {{ auth()->user()->can('product.update') ? 'true' : 'false' }};
    </script>
    <script src="{{ asset('js/pos.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/printer.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/product.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/opening_stock.js?v=' . $asset_v) }}"></script>
    @include('sale_pos.partials.keyboard_shortcuts')

    @if (in_array('tables', $enabled_modules) ||
            in_array('modifiers', $enabled_modules) ||
            in_array('service_staff', $enabled_modules))
        <script src="{{ asset('js/restaurant.js?v=' . $asset_v) }}"></script>
    @endif
    @if (!empty($pos_module_data))
        @foreach ($pos_module_data as $key => $value)
            @if (!empty($value['module_js_path']))
                @includeIf($value['module_js_path'], ['view_data' => $value['view_data']])
            @endif
        @endforeach
    @endif
@endsection
