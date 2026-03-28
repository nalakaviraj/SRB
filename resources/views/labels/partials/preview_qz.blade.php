@php
	$rotate_labels = !empty($barcode_details->rotate_labels);
	$label_width = $barcode_details->width * 1;
	$label_height = $barcode_details->height * 1;
	$inner_width = $rotate_labels ? $label_height : $label_width;
	$inner_height = $rotate_labels ? $label_width : $label_height;
	$business_name_scale = 0.8;
	$barcode_height_factor = 0.32;
@endphp
<!doctype html>
<html>
	<head>
		<style type="text/css">
			@page {
				size: {{$label_width}}in {{$label_height}}in;
				margin: 0;
			}
			body {
				margin: 0;
				padding: 0;
			}
			.label-page {
				width: {{$label_width}}in;
				height: {{$label_height}}in;
			}
			.label-outer {
				position: relative;
				width: {{$label_width}}in;
				height: {{$label_height}}in;
				overflow: hidden;
			}
			.label-inner {
				position: relative;
				width: {{$inner_width}}in;
				height: {{$inner_height}}in;
				overflow: hidden;
			}
			.label-inner.rotate {
				position: absolute;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%) rotate(90deg);
				transform-origin: center;
			}
			.label-content {
				position: absolute;
				width: {{$inner_width}}in;
				height: {{$inner_height}}in;
				text-align: center;
				transform-origin: top center;
			}
			.label-line {
				display: block;
				white-space: nowrap;
				overflow: hidden;
				line-height: 1.0;
				margin: 0;
				padding: 0;
			}
		</style>
	</head>
	<body>
	@foreach($labels as $page_product)
		@php
			$line_height_factor = 1.0;
			$content_height_in = 0.0;

			if (!empty($print['business_name'])) {
				$content_height_in += ($print['business_name_size'] * $business_name_scale * $line_height_factor) / 96;
			}
			if (!empty($print['name'])) {
				$content_height_in += ($print['name_size'] * $line_height_factor) / 96;
			}
			if (!empty($print['price'])) {
				$content_height_in += ($print['price_size'] * $line_height_factor) / 96;
			}
			$content_height_in += (10 * $line_height_factor) / 96;
			$content_height_in += ($barcode_details->height * $barcode_height_factor);

			$available_height_in = max(0.05, $inner_height - (1 / 25.4));
			$scale = $content_height_in > 0 ? min(1, $available_height_in / $content_height_in) : 1;
		@endphp
		<div class="label-page" style="page-break-after: {{ $loop->last ? 'auto' : 'always' }};">
			<div class="label-outer">
				<div class="label-inner @if($rotate_labels) rotate @endif">
					<div class="label-content" style="left: 50%; top: 0; transform: translateX(-50%) scale({{$scale}});">
						@if(!empty($print['business_name']))
							<b class="label-line" style="font-size: {{round($print['business_name_size'] * $business_name_scale, 2)}}px">SR&amp;BC</b>
						@endif

						@if(!empty($print['name']))
							<span class="label-line" style="font-size: {{$print['name_size']}}px">
								{{$page_product->product_actual_name}}

								@if(!empty($print['lot_number']) && !empty($page_product->lot_number))
									<span style="font-size: 12px">
										 ({{$page_product->lot_number}})
									</span>
								@endif
							</span>
						@endif

						@if(!empty($print['price']))
                                <span class="label-line" style="font-size: {{$print['name_size']}}px;">
                                    <b>Rs 
								@if($print['price_type'] == 'inclusive')
									{{@num_format($page_product->sell_price_inc_tax)}}
								@else
									{{@num_format($page_product->default_sell_price)}}
								@endif</b>
							</span>
						@endif
						<img style="max-width:90% !important;height: {{$barcode_details->height * $barcode_height_factor}}in !important; display: block; margin: 0 auto;" src="data:image/png;base64,{{DNS1D::getBarcodePNG($page_product->sub_sku, $page_product->barcode_type, 3,90, array(0, 0, 0), false)}}">
						
						<span class="label-line" style="font-size: 10px !important">
							{{$page_product->sub_sku}}
						</span>
					</div>
				</div>
			</div>
		</div>
	@endforeach
	</body>
</html>
