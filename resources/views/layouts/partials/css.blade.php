<link href="{{ asset('css/tailwind/app.css?v='.$asset_v) }}" rel="stylesheet">

<link rel="stylesheet" href="{{ asset('css/vendor.css?v='.$asset_v) }}">

@if( in_array(session()->get('user.language', config('app.locale')), config('constants.langs_rtl')) )
	<link rel="stylesheet" href="{{ asset('css/rtl.css?v='.$asset_v) }}">
@endif

@yield('css')

<!-- app css -->
<link rel="stylesheet" href="{{ asset('css/app.css?v='.$asset_v) }}">

@if(isset($pos_layout) && $pos_layout)
	<style type="text/css">
		.content{
			padding-bottom: 0px !important;
		}
	</style>
@endif
<style type="text/css">
	/*
	* Pattern lock css
	* Pattern direction
	* http://ignitersworld.com/lab/patternLock.html
	*/
	.patt-wrap {
	  z-index: 10;
	}
	.patt-circ.hovered {
	  background-color: #cde2f2;
	  border: none;
	}
	.patt-circ.hovered .patt-dots {
	  display: none;
	}
	.patt-circ.dir {
	  background-image: url("{{asset('/img/pattern-directionicon-arrow.png')}}");
	  background-position: center;
	  background-repeat: no-repeat;
	}
	.patt-circ.e {
	  -webkit-transform: rotate(0);
	  transform: rotate(0);
	}
	.patt-circ.s-e {
	  -webkit-transform: rotate(45deg);
	  transform: rotate(45deg);
	}
	.patt-circ.s {
	  -webkit-transform: rotate(90deg);
	  transform: rotate(90deg);
	}
	.patt-circ.s-w {
	  -webkit-transform: rotate(135deg);
	  transform: rotate(135deg);
	}
	.patt-circ.w {
	  -webkit-transform: rotate(180deg);
	  transform: rotate(180deg);
	}
	.patt-circ.n-w {
	  -webkit-transform: rotate(225deg);
	   transform: rotate(225deg);
	}
	.patt-circ.n {
	  -webkit-transform: rotate(270deg);
	  transform: rotate(270deg);
	}
	.patt-circ.n-e {
	  -webkit-transform: rotate(315deg);
	  transform: rotate(315deg);
	}
</style>
@if(!empty($__system_settings['additional_css']))
    {!! $__system_settings['additional_css'] !!}
@endif

@if(isset($pos_layout) && $pos_layout)
	<style type="text/css">
		:root {
			--pos-focus-ring: #1e6cff;
			--pos-focus-glow: rgba(30, 108, 255, 0.35);
			--pos-focus-bg: #fff8d6;
		}
		body.pos-layout :focus {
			outline: 3px solid var(--pos-focus-ring) !important;
			outline-offset: 2px;
			box-shadow: 0 0 0 3px var(--pos-focus-glow) !important;
		}
		body.pos-layout input:focus,
		body.pos-layout select:focus,
		body.pos-layout textarea:focus,
		body.pos-layout .form-control:focus,
		body.pos-layout .select2-container--default .select2-selection--single,
		body.pos-layout .select2-container--default .select2-selection--multiple {
			border-color: var(--pos-focus-ring) !important;
			background-color: var(--pos-focus-bg) !important;
		}
		body.pos-layout .select2-container--default.select2-container--focus .select2-selection--single,
		body.pos-layout .select2-container--default.select2-container--focus .select2-selection--multiple {
			border-color: var(--pos-focus-ring) !important;
		}
		body.pos-layout .input-group:focus-within,
		body.pos-layout .form-group:focus-within {
			box-shadow: 0 0 0 3px var(--pos-focus-glow);
			border-radius: 6px;
		}
	</style>
@endif
