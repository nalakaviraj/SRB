@foreach($featured_products as $variation)
	<div class="col-md-3 col-xs-4 product_list no-print">
		<div class="product_box hover:tw-shadow-lg hover:tw-animate-pulse" data-toggle="tooltip" data-placement="bottom" data-variation_id="{{$variation->id}}" title="{{$variation->full_name}}">

		<div class="text_div">
			<small class="text text-muted">{{$variation->product->name}} 
			@if($variation->product->type == 'variable')
				- {{$variation->name}}
			@endif
			</small>

			<small class="text-muted">
				({{$variation->sub_sku}})
			</small>
		</div>
			
		</div>
	</div>
@endforeach
