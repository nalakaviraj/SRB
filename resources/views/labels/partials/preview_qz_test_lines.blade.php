@php
	$rotate_labels = !empty($barcode_details->rotate_labels);
	$label_width = $barcode_details->width * 1;
	$label_height = $barcode_details->height * 1;
	$inner_width = $rotate_labels ? $label_height : $label_width;
	$inner_height = $rotate_labels ? $label_width : $label_height;
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
				page-break-after: always;
			}
			.label-outer {
				position: relative;
				width: {{$label_width}}in;
				height: {{$label_height}}in;
				overflow: hidden;
			}
			.label-inner {
				display: block;
				width: {{$inner_width}}in;
				height: {{$inner_height}}in;
				overflow: hidden;
				padding-bottom: {{$safe_margin_in}}in;
			}
			.label-inner.rotate {
				position: absolute;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%) rotate(90deg);
				transform-origin: center;
			}
			.line {
				width: 100%;
				border-top: 0.01in solid #000;
				height: {{$line_gap_in}}in;
				box-sizing: border-box;
			}
		</style>
	</head>
	<body>
		<div class="label-page">
			<div class="label-outer">
				<div class="label-inner @if($rotate_labels) rotate @endif">
					@for($i = 0; $i < $line_count; $i++)
						<div class="line"></div>
					@endfor
				</div>
			</div>
		</div>
	</body>
</html>
