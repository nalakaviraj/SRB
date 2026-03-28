@extends('layouts.app')

@section('title', __('barcode.print_labels'))

@section('content')
<section class="content-header">
    <h1>@lang('barcode.print_labels')</h1>
</section>

<section class="content">
    <div class="alert alert-success">
        @lang('product.product_added_success')
    </div>
    <div id="label_popup_blocked" class="alert alert-warning" style="display:none;">
        Please allow popups or use the Print Labels button below.
    </div>
    <p>Opening label print window...</p>
    <p>
        <a id="label_print_manual" class="tw-dw-btn tw-dw-btn-primary tw-text-white tw-mr-2" href="{{ action([\App\Http\Controllers\LabelsController::class, 'show'], ['product_id' => $product_id]) }}" target="_blank">
            @lang('barcode.print_labels')
        </a>
        <a class="tw-dw-btn tw-dw-btn-secondary" href="#" onclick="history.back(); return false;">@lang('lang_v1.back')</a>
    </p>
</section>
@endsection

@section('javascript')
<script type="text/javascript">
    (function() {
        var url = "{{ action([\App\Http\Controllers\LabelsController::class, 'show'], ['product_id' => $product_id]) }}";
        var win = null;
        try {
            win = window.open('', 'label_print');
        } catch (e) {
            win = null;
        }
        if (win && !win.closed) {
            win.location = url;
            if (typeof win.focus === 'function') {
                win.focus();
            }
        } else {
            var warn = document.getElementById('label_popup_blocked');
            if (warn) {
                warn.style.display = 'block';
            }
            if (typeof toastr !== 'undefined') {
                toastr.error('Please allow popups to open the label print window.');
            }
        }
    })();
</script>
@endsection
