(function(window, $) {
    'use strict';

    var stationIdKey = 'print_station_id';
    var stationStartedKey = 'print_station_started_at';
    var polling = false;

    function getStationId() {
        var id = localStorage.getItem(stationIdKey);
        if (!id) {
            id = 'station_' + Math.random().toString(36).substr(2, 9) + Date.now().toString(36);
            localStorage.setItem(stationIdKey, id);
        }
        return id;
    }

    function setStatus(text) {
        $('#print_station_status').text(text);
    }

    function getStartedAt() {
        var startedAt = localStorage.getItem(stationStartedKey);
        if (!startedAt) {
            startedAt = new Date().toISOString();
            localStorage.setItem(stationStartedKey, startedAt);
        }
        return startedAt;
    }

    function fetchNextJob() {
        if (polling) {
            return;
        }
        polling = true;

        $.ajax({
            method: 'GET',
            url: base_path + '/print-station/next',
            dataType: 'json',
            data: {
                station_id: getStationId(),
                type: 'label',
                started_at: getStartedAt()
            }
        }).done(function(result) {
            if (!result.success || !result.data) {
                polling = false;
                setTimeout(fetchNextJob, 1500);
                return;
            }

            var job = result.data;
            setStatus('Printing job #' + job.id);

            if (!window.qzHelper) {
                markDone(job.id, 'failed', 'QZ Tray not loaded');
                polling = false;
                setTimeout(fetchNextJob, 1500);
                return;
            }

            window.qzHelper.printLabelsFromData(job.payload.form)
                .then(function() {
                    markDone(job.id, 'done', null);
                })
                .catch(function(err) {
                    var message = err && err.message ? err.message : 'Print failed';
                    markDone(job.id, 'failed', message);
                })
                .finally(function() {
                    polling = false;
                    setTimeout(fetchNextJob, 500);
                });
        }).fail(function() {
            polling = false;
            setTimeout(fetchNextJob, 2000);
        });
    }

    function markDone(jobId, status, error) {
        $.ajax({
            method: 'POST',
            url: base_path + '/print-station/jobs/' + jobId + '/done',
            dataType: 'json',
            data: {
                status: status,
                error: error
            }
        }).always(function() {
            setStatus(status === 'done' ? 'Idle' : 'Error: ' + (error || 'Unknown'));
        });
    }

    $(document).ready(function() {
        setStatus('Idle');
        fetchNextJob();

        $('#print_station_clear').on('click', function() {
            $.ajax({
                method: 'POST',
                url: base_path + '/print-station/clear',
                dataType: 'json',
                data: {
                    type: 'label'
                }
            }).done(function(result) {
                if (result && result.success) {
                    setStatus('Queue cleared');
                } else {
                    setStatus('Failed to clear queue');
                }
            }).fail(function() {
                setStatus('Failed to clear queue');
            });
        });
    });
})(window, window.jQuery);
