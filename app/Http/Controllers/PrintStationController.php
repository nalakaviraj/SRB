<?php

namespace App\Http\Controllers;

use App\PrintJob;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PrintStationController extends Controller
{
    public function index()
    {
        return view('print_station.index');
    }

    public function nextJob(Request $request)
    {
        $business_id = $request->session()->get('user.business_id');
        $station_id = (string) $request->get('station_id');
        $type = $request->get('type', 'label');
        $started_at = $request->get('started_at');

        if (empty($station_id)) {
            return response()->json([
                'success' => false,
                'msg' => 'Missing station_id',
            ], 422);
        }

        if (!empty($started_at)) {
            try {
                $started_at = \Carbon\Carbon::parse($started_at);
            } catch (\Exception $e) {
                $started_at = null;
            }
        }

        $job = DB::transaction(function () use ($business_id, $station_id, $type, $started_at) {
            $job = PrintJob::where('business_id', $business_id)
                ->where('type', $type)
                ->where('status', 'pending')
                ->when(!empty($started_at), function ($query) use ($started_at) {
                    $query->where('created_at', '>=', $started_at);
                })
                ->orderBy('id')
                ->lockForUpdate()
                ->first();

            if (empty($job)) {
                return null;
            }

            $job->status = 'printing';
            $job->station_id = $station_id;
            $job->started_at = now();
            $job->save();

            return $job;
        });

        if (empty($job)) {
            return response()->json([
                'success' => true,
                'data' => null,
            ]);
        }

        return response()->json([
            'success' => true,
            'data' => [
                'id' => $job->id,
                'type' => $job->type,
                'payload' => $job->payload,
            ],
        ]);
    }

    public function markDone(Request $request, $id)
    {
        $business_id = $request->session()->get('user.business_id');
        $status = $request->get('status', 'done');
        $error = $request->get('error');

        $job = PrintJob::where('business_id', $business_id)->findOrFail($id);
        $job->status = $status === 'failed' ? 'failed' : 'done';
        $job->completed_at = now();
        $job->error = $status === 'failed' ? $error : null;
        $job->save();

        return response()->json([
            'success' => true,
        ]);
    }

    public function clearQueue(Request $request)
    {
        $business_id = $request->session()->get('user.business_id');
        $type = $request->get('type', 'label');

        PrintJob::where('business_id', $business_id)
            ->where('type', $type)
            ->where('status', 'pending')
            ->update([
                'status' => 'cancelled',
                'completed_at' => now(),
            ]);

        return response()->json([
            'success' => true,
        ]);
    }
}
