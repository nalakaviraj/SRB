@if(!session('business.enable_price_tax')) 
  @php
    $default = 0;
    $class = 'hide';
  @endphp
@else
  @php
    $default = null;
    $class = '';
  @endphp
@endif

<div class="table-responsive">
    <table class="table table-bordered add-product-price-table table-condensed {{$class}}">
        <tr>
          <th>Cost Price</th>
          <th>Margin</th>
          <th>Selling Price</th>
        </tr>
        <tr>
          <td>
            {!! Form::label('single_dpp', 'Cost Price:*') !!}
            {!! Form::text('single_dpp', $default, ['class' => 'form-control input-sm dpp input_number', 'required', 'id' => 'single_dpp']); !!}
            {!! Form::hidden('single_dpp_inc_tax', $default, ['class' => 'dpp_inc_tax input_number', 'id' => 'single_dpp_inc_tax']); !!}
          </td>

          <td>
            {!! Form::label('profit_percent', 'Margin:') !!}
            {!! Form::text('profit_percent', @num_format($profit_percent), ['class' => 'form-control input-sm input_number', 'id' => 'profit_percent', 'required']); !!}
          </td>

          <td>
            {!! Form::label('single_dsp', 'Selling Price:*') !!}
            {!! Form::text('single_dsp', $default, ['class' => 'form-control input-sm dsp input_number', 'id' => 'single_dsp', 'required']); !!}
            {!! Form::hidden('single_dsp_inc_tax', $default, ['class' => 'input_number', 'id' => 'single_dsp_inc_tax']); !!}
          </td>
        </tr>
    </table>
</div>
