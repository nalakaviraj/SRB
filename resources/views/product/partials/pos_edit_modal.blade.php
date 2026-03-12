<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        {!! Form::open(['url' => action([\App\Http\Controllers\ProductController::class, 'updatePos'], [$product->id]), 'method' => 'post', 'id' => 'pos_edit_product_form' ]) !!}
        @csrf
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title">@lang('product.edit_product')</h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        {!! Form::label('name', __('product.product_name') . ':*') !!}
                        {!! Form::text('name', $product->name, ['class' => 'form-control', 'required']) !!}
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        {!! Form::label('sku', __('product.sku') . ':') !!} @show_tooltip(__('tooltip.sku'))
                        {!! Form::text('sku', $product->sku, ['class' => 'form-control']) !!}
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        {!! Form::label('barcode_type', __('product.barcode_type') . ':*') !!}
                        {!! Form::select('barcode_type', $barcode_types, $product->barcode_type, ['class' => 'form-control select2', 'required']) !!}
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="col-sm-4">
                    <div class="form-group">
                        {!! Form::label('single_dpp', 'Cost Price:*') !!}
                        {!! Form::text('single_dpp', @num_format($variation->default_purchase_price), ['class' => 'form-control input_number', 'id' => 'pos_edit_cost_price', 'required']) !!}
                        {!! Form::hidden('single_dpp_inc_tax', @num_format($variation->default_purchase_price), ['id' => 'single_dpp_inc_tax']) !!}
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        {!! Form::label('profit_percent', 'Margin:') !!}
                        {!! Form::text('profit_percent', @num_format($variation->profit_percent), ['class' => 'form-control input_number', 'id' => 'pos_edit_margin', 'required']) !!}
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        {!! Form::label('single_dsp', 'Selling Price:*') !!}
                        {!! Form::text('single_dsp', @num_format($variation->default_sell_price), ['class' => 'form-control input_number', 'id' => 'pos_edit_selling_price', 'required']) !!}
                        {!! Form::hidden('single_dsp_inc_tax', @num_format($variation->default_sell_price), ['id' => 'single_dsp_inc_tax']) !!}
                    </div>
                </div>

                <div class="clearfix"></div>

                <div class="col-sm-4">
                    <div class="form-group">
                        {!! Form::label('current_quantity', 'Current Quantity:') !!}
                        {!! Form::text('current_quantity', @num_format($current_quantity), ['class' => 'form-control input_number', 'id' => 'current_quantity']) !!}
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        {!! Form::label('current_quantity_location', __('business.business_locations') . ':') !!}
                        {!! Form::select('current_quantity_location', $locations, $location_id, ['class' => 'form-control select2', 'id' => 'pos_edit_location_id']) !!}
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <br>
                        <label>
                            {!! Form::checkbox('enable_stock', 1, $product->enable_stock, ['class' => 'input-icheck', 'id' => 'enable_stock']); !!}
                            <strong>@lang('product.manage_stock')</strong>
                        </label>
                        @show_tooltip(__('tooltip.enable_stock'))
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">@lang('messages.close')</button>
            <button type="submit" class="btn btn-primary">@lang('messages.update')</button>
        </div>
        {!! Form::close() !!}
    </div>
</div>
