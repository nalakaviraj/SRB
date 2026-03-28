<?php

namespace App\Http\Controllers;

use App\Barcode;
use App\Product;
use App\SellingPriceGroup;
use App\Utils\ProductUtil;
use App\Utils\TransactionUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LabelsController extends Controller
{
    /**
     * All Utils instance.
     */
    protected $transactionUtil;

    protected $productUtil;

    /**
     * Constructor
     *
     * @param  TransactionUtil  $TransactionUtil
     * @return void
     */
    public function __construct(TransactionUtil $transactionUtil, ProductUtil $productUtil)
    {
        $this->transactionUtil = $transactionUtil;
        $this->productUtil = $productUtil;
    }

    /**
     * Display labels
     *
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request)
    {
        $business_id = $request->session()->get('user.business_id');
        $purchase_id = $request->get('purchase_id', false);
        $product_id = $request->get('product_id', false);

        //Get products for the business
        $products = [];
        $price_groups = [];
        if ($purchase_id) {
            $products = $this->transactionUtil->getPurchaseProducts($business_id, $purchase_id);
        } elseif ($product_id) {
            $products = $this->productUtil->getDetailsFromProduct($business_id, $product_id);
        }

        //get price groups
        $price_groups = [];
        if (! empty($purchase_id) || ! empty($product_id)) {
            $price_groups = SellingPriceGroup::where('business_id', $business_id)
                                    ->active()
                                    ->pluck('name', 'id');
        }

        $barcode_settings = Barcode::where('business_id', $business_id)
                                ->orWhereNull('business_id')
                                ->select(DB::raw('CONCAT(name, ", ", COALESCE(description, "")) as name, id, is_default'))
                                ->get();
        $default = $barcode_settings->where('is_default', 1)->first();
        $barcode_settings = $barcode_settings->pluck('name', 'id');

        return view('labels.show')
            ->with(compact('products', 'barcode_settings', 'default', 'price_groups'));
    }

    /**
     * Returns the html for product row
     *
     * @return \Illuminate\Http\Response
     */
    public function addProductRow(Request $request)
    {
        if ($request->ajax()) {
            $product_id = $request->input('product_id');
            $variation_id = $request->input('variation_id');
            $business_id = $request->session()->get('user.business_id');

            if (! empty($product_id)) {
                $index = $request->input('row_count');
                $products = $this->productUtil->getDetailsFromProduct($business_id, $product_id, $variation_id);

                $price_groups = SellingPriceGroup::where('business_id', $business_id)
                                            ->active()
                                            ->pluck('name', 'id');

                return view('labels.partials.show_table_rows')
                        ->with(compact('products', 'index', 'price_groups'));
            }
        }
    }

    /**
     * Returns the html for labels preview
     *
     * @return \Illuminate\Http\Response
     */
    public function preview(Request $request)
    {
        try {
            $products = $request->get('products');
            $print = $request->get('print');
            $barcode_setting = $request->get('barcode_setting');
            $business_id = $request->session()->get('user.business_id');

            $barcode_details = Barcode::find($barcode_setting);
            $barcode_details->stickers_in_one_sheet = $barcode_details->is_continuous ? $barcode_details->stickers_in_one_row : $barcode_details->stickers_in_one_sheet;
            $barcode_details->paper_height = $barcode_details->is_continuous ? $barcode_details->height : $barcode_details->paper_height;
            if ($barcode_details->stickers_in_one_row == 1) {
                $barcode_details->col_distance = 0;
                $barcode_details->row_distance = 0;
            }
            $barcode_details = $this->convertBarcodeMeasurementsToInches($barcode_details);
            // if($barcode_details->is_continuous){
            //     $barcode_details->row_distance = 0;
            // }

            $business_name = $request->session()->get('business.name');

            $product_details_page_wise = [];
            $total_qty = 0;
            foreach ($products as $value) {
                $details = $this->productUtil->getDetailsFromVariation($value['variation_id'], $business_id, null, false);

                if (! empty($value['exp_date'])) {
                    $details->exp_date = $value['exp_date'];
                }
                if (! empty($value['packing_date'])) {
                    $details->packing_date = $value['packing_date'];
                }
                if (! empty($value['lot_number'])) {
                    $details->lot_number = $value['lot_number'];
                }

                if (! empty($value['price_group_id'])) {
                    $tax_id = $print['price_type'] == 'inclusive' ?: $details->tax_id;

                    $group_prices = $this->productUtil->getVariationGroupPrice($value['variation_id'], $value['price_group_id'], $tax_id);

                    $details->sell_price_inc_tax = $group_prices['price_inc_tax'];
                    $details->default_sell_price = $group_prices['price_exc_tax'];
                }

                for ($i = 0; $i < $value['quantity']; $i++) {
                    $page = intdiv($total_qty, $barcode_details->stickers_in_one_sheet);

                    if ($total_qty % $barcode_details->stickers_in_one_sheet == 0) {
                        $product_details_page_wise[$page] = [];
                    }

                    $product_details_page_wise[$page][] = $details;
                    $total_qty++;
                }
            }

            $margin_top = $barcode_details->is_continuous ? 0 : $barcode_details->top_margin * 1;
            $margin_left = $barcode_details->is_continuous ? 0 : $barcode_details->left_margin * 1;
            $paper_width = ($barcode_details->is_continuous ? $barcode_details->width : $barcode_details->paper_width) * 1;
            $paper_height = $barcode_details->paper_height * 1;

            // print_r($paper_height);
            // echo "==";
            // print_r($margin_left);exit;

            // $mpdf = new \Mpdf\Mpdf(['mode' => 'utf-8',
            //             'format' => [$paper_width, $paper_height],
            //             'margin_top' => $margin_top,
            //             'margin_bottom' => $margin_top,
            //             'margin_left' => $margin_left,
            //             'margin_right' => $margin_left,
            //             'autoScriptToLang' => true,
            //             // 'disablePrintCSS' => true,
            // 'autoLangToFont' => true,
            // 'autoVietnamese' => true,
            // 'autoArabic' => true
            //             ]
            //         );
            //print_r($mpdf);exit;

            $i = 0;
            $len = count($product_details_page_wise);
            $is_first = false;
            $is_last = false;

            //$original_aspect_ratio = 4;//(w/h)
            $factor = (($barcode_details->width / $barcode_details->height)) / ($barcode_details->is_continuous ? 2 : 4);
            $html = '';
            foreach ($product_details_page_wise as $page => $page_products) {
                if ($i == 0) {
                    $is_first = true;
                }

                if ($i == $len - 1) {
                    $is_last = true;
                }

                $output = view('labels.partials.preview_2')
                            ->with(compact('print', 'page_products', 'business_name', 'barcode_details', 'margin_top', 'margin_left', 'paper_width', 'paper_height', 'is_first', 'is_last', 'factor'))->render();
                print_r($output);
                //$mpdf->WriteHTML($output);

                // if($i < $len - 1){
                //     // '', '', '', '', '', '', $margin_left, $margin_left, $margin_top, $margin_top, '', '', '', '', '', '', 0, 0, 0, 0, '', [$barcode_details->paper_width*1, $barcode_details->paper_height*1]
                //     $mpdf->AddPage();
                // }

                $i++;
            }

            print_r('<script>window.print()</script>');
            exit;
            //return $output;

            //$mpdf->Output();

            // $page_height = null;
            // if ($barcode_details->is_continuous) {
            //     $rows = ceil($total_qty/$barcode_details->stickers_in_one_row) + 0.4;
            //     $barcode_details->paper_height = $barcode_details->top_margin + ($rows*$barcode_details->height) + ($rows*$barcode_details->row_distance);
            // }

            // $output = view('labels.partials.preview')
            //     ->with(compact('print', 'product_details', 'business_name', 'barcode_details', 'product_details_page_wise'))->render();

            // $output = ['html' => $html,
            //                 'success' => true,
            //                 'msg' => ''
            //             ];
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            $output = __('lang_v1.barcode_label_error');
        }

        //return $output;
    }

    public function qzPdf(Request $request)
    {
        try {
            $products = $request->get('products');
            $print = $request->get('print');
            $barcode_setting = $request->get('barcode_setting');
            $business_id = $request->session()->get('user.business_id');

            if (empty($products) || empty($barcode_setting)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 422);
            }

            $barcode_details = Barcode::find($barcode_setting);
            $barcode_details->stickers_in_one_sheet = $barcode_details->is_continuous ? $barcode_details->stickers_in_one_row : $barcode_details->stickers_in_one_sheet;
            $barcode_details->paper_height = $barcode_details->is_continuous ? $barcode_details->height : $barcode_details->paper_height;
            if ($barcode_details->stickers_in_one_row == 1) {
                $barcode_details->col_distance = 0;
                $barcode_details->row_distance = 0;
            }
            $barcode_details = $this->convertBarcodeMeasurementsToInches($barcode_details);

            $barcode_details->stickers_in_one_row = 1;
            $barcode_details->stickers_in_one_sheet = 1;
            $barcode_details->row_distance = 0;
            $barcode_details->col_distance = 0;

            $business_name = $request->session()->get('business.name');

            $labels = [];
            foreach ($products as $value) {
                $details = $this->productUtil->getDetailsFromVariation($value['variation_id'], $business_id, null, false);

                if (! empty($value['exp_date'])) {
                    $details->exp_date = $value['exp_date'];
                }
                if (! empty($value['packing_date'])) {
                    $details->packing_date = $value['packing_date'];
                }
                if (! empty($value['lot_number'])) {
                    $details->lot_number = $value['lot_number'];
                }

                if (! empty($value['price_group_id'])) {
                    $tax_id = $print['price_type'] == 'inclusive' ?: $details->tax_id;

                    $group_prices = $this->productUtil->getVariationGroupPrice($value['variation_id'], $value['price_group_id'], $tax_id);

                    $details->sell_price_inc_tax = $group_prices['price_inc_tax'];
                    $details->default_sell_price = $group_prices['price_exc_tax'];
                }

                for ($i = 0; $i < $value['quantity']; $i++) {
                    $labels[] = $details;
                }
            }

            $html = view('labels.partials.preview_qz')
                ->with(compact('print', 'labels', 'business_name', 'barcode_details'))
                ->render();

            $width_pt = $barcode_details->width * 72;
            $height_pt = $barcode_details->height * 72;
            $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadHTML($html)
                ->setPaper([0, 0, $width_pt, $height_pt]);

            $base64 = base64_encode($pdf->output());

            return response()->json([
                'success' => true,
                'data' => [
                    'pdf' => $base64,
                    'width_mm' => round($barcode_details->width * 25.4, 2),
                    'height_mm' => round($barcode_details->height * 25.4, 2),
                ],
            ]);
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            return response()->json([
                'success' => false,
                'msg' => __('lang_v1.barcode_label_error'),
            ], 500);
        }
    }

    public function quickPrintData(Request $request)
    {
        try {
            $product_id = $request->get('product_id');
            $business_id = $request->session()->get('user.business_id');
            if (empty($product_id)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('messages.something_went_wrong'),
                ], 422);
            }

            $product = Product::where('business_id', $business_id)
                ->with(['variations'])
                ->findOrFail($product_id);
            $variation = $product->variations->first();
            if (! $variation) {
                return response()->json([
                    'success' => false,
                    'msg' => __('messages.something_went_wrong'),
                ], 422);
            }

            $barcode_setting = Barcode::where('business_id', $business_id)
                ->orWhereNull('business_id')
                ->where('is_default', 1)
                ->value('id');

            if (empty($barcode_setting)) {
                $barcode_setting = Barcode::where('business_id', $business_id)
                    ->orWhereNull('business_id')
                    ->orderBy('id', 'asc')
                    ->value('id');
            }

            if (empty($barcode_setting)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 422);
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'product_id' => $product->id,
                    'variation_id' => $variation->id,
                    'barcode_setting' => $barcode_setting,
                ],
            ]);
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            return response()->json([
                'success' => false,
                'msg' => __('messages.something_went_wrong'),
            ], 500);
        }
    }

    public function queuePrint(Request $request)
    {
        try {
            $barcode_setting = $request->get('barcode_setting');
            $products = $request->get('products');

            if (empty($barcode_setting) || empty($products)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 422);
            }

            $business_id = $request->session()->get('user.business_id');
            $user_id = $request->session()->get('user.id');

            $payload = [
                'form' => $request->getContent(),
            ];

            \App\PrintJob::create([
                'business_id' => $business_id,
                'created_by' => $user_id,
                'type' => 'label',
                'status' => 'pending',
                'payload' => $payload,
            ]);

            return response()->json([
                'success' => true,
                'msg' => 'Queued for print station.',
            ]);
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            return response()->json([
                'success' => false,
                'msg' => __('lang_v1.barcode_label_error'),
            ], 500);
        }
    }

    public function qzTestLines(Request $request)
    {
        try {
            $barcode_setting = $request->get('barcode_setting');
            if (empty($barcode_setting)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 422);
            }

            $barcode_details = Barcode::find($barcode_setting);
            if (empty($barcode_details)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 404);
            }

            $barcode_details->stickers_in_one_sheet = $barcode_details->is_continuous ? $barcode_details->stickers_in_one_row : $barcode_details->stickers_in_one_sheet;
            $barcode_details->paper_height = $barcode_details->is_continuous ? $barcode_details->height : $barcode_details->paper_height;
            if ($barcode_details->stickers_in_one_row == 1) {
                $barcode_details->col_distance = 0;
                $barcode_details->row_distance = 0;
            }
            $barcode_details = $this->convertBarcodeMeasurementsToInches($barcode_details);

            $line_gap_in = 1 / 25.4;
            $inner_height = !empty($barcode_details->rotate_labels) ? $barcode_details->width : $barcode_details->height;
            $safe_margin_in = 2 / 25.4;
            $usable_height = max(0.05, $inner_height - $safe_margin_in);
            $line_count = max(1, (int) floor($usable_height / $line_gap_in));

            $html = view('labels.partials.preview_qz_test_lines')
                ->with(compact('barcode_details', 'line_gap_in', 'line_count', 'safe_margin_in'))
                ->render();

            $width_pt = $barcode_details->width * 72;
            $height_pt = $barcode_details->height * 72;
            $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadHTML($html)
                ->setPaper([0, 0, $width_pt, $height_pt]);

            $base64 = base64_encode($pdf->output());

            return response()->json([
                'success' => true,
                'data' => [
                    'pdf' => $base64,
                    'width_mm' => round($barcode_details->width * 25.4, 2),
                    'height_mm' => round($barcode_details->height * 25.4, 2),
                ],
            ]);
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            return response()->json([
                'success' => false,
                'msg' => __('lang_v1.barcode_label_error'),
            ], 500);
        }
    }

    public function qzTsplConfig(Request $request)
    {
        try {
            $barcode_setting = $request->get('barcode_setting');
            if (empty($barcode_setting)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 422);
            }

            $barcode_details = Barcode::find($barcode_setting);
            if (empty($barcode_details)) {
                return response()->json([
                    'success' => false,
                    'msg' => __('lang_v1.barcode_label_error'),
                ], 404);
            }

            $barcode_details->stickers_in_one_sheet = $barcode_details->is_continuous ? $barcode_details->stickers_in_one_row : $barcode_details->stickers_in_one_sheet;
            $barcode_details->paper_height = $barcode_details->is_continuous ? $barcode_details->height : $barcode_details->paper_height;
            if ($barcode_details->stickers_in_one_row == 1) {
                $barcode_details->col_distance = 0;
                $barcode_details->row_distance = 0;
            }
            $barcode_details = $this->convertBarcodeMeasurementsToInches($barcode_details);

            return response()->json([
                'success' => true,
                'data' => [
                    'width_mm' => round($barcode_details->width * 25.4, 2),
                    'height_mm' => round($barcode_details->height * 25.4, 2),
                    'gap_mm' => (float) config('constants.qz_label_gap_mm', 3),
                ],
            ]);
        } catch (\Exception $e) {
            \Log::emergency('File:'.$e->getFile().'Line:'.$e->getLine().'Message:'.$e->getMessage());

            return response()->json([
                'success' => false,
                'msg' => __('lang_v1.barcode_label_error'),
            ], 500);
        }
    }

    private function convertBarcodeMeasurementsToInches($barcode_details)
    {
        $unit = $barcode_details->measurement_unit ?? 'in';
        if ($unit !== 'mm' && $barcode_details->is_continuous) {
            $dimensions = array_filter([
                $barcode_details->width,
                $barcode_details->height,
                $barcode_details->paper_width,
                $barcode_details->paper_height,
            ], function ($value) {
                return ! is_null($value);
            });

            if (! empty($dimensions)) {
                $max_dimension = max($dimensions);
                if ($max_dimension >= 8 && $max_dimension <= 200) {
                    $unit = 'mm';
                }
            }
        }

        if ($unit !== 'mm') {
            return $barcode_details;
        }

        $mm_to_in = 1 / 25.4;
        $fields = [
            'width',
            'height',
            'paper_width',
            'paper_height',
            'top_margin',
            'left_margin',
            'row_distance',
            'col_distance',
        ];

        foreach ($fields as $field) {
            if (! is_null($barcode_details->$field)) {
                $barcode_details->$field = $barcode_details->$field * $mm_to_in;
            }
        }

        return $barcode_details;
    }
}
