@extends('layouts.app')

@section('title', 'Print Station')

@section('content')
<section class="content-header">
    <h1 class="tw-text-xl md:tw-text-3xl tw-font-bold tw-text-black">Print Station</h1>
</section>

<section class="content">
    <div class="box box-primary">
        <div class="box-body">
            <p>Keep this page open on the PC connected to the printer.</p>
            <p>Status: <strong id="print_station_status">Starting...</strong></p>
            <button type="button" id="print_station_clear" class="tw-dw-btn tw-dw-btn-outline tw-dw-btn-warning">Clear Pending Queue</button>
        </div>
    </div>
</section>
@endsection

@section('javascript')
    <script src="{{ asset('js/qz-tray.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/qz-helper.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/print-station.js?v=' . $asset_v) }}"></script>
@endsection
