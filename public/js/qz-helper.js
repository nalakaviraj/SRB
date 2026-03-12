(function(window, $) {
    'use strict';

    var connectPromise = null;

    function connect() {
        if (!window.qz) {
            return Promise.reject(new Error('QZ Tray not loaded'));
        }
        if (qz.websocket.isActive()) {
            return Promise.resolve();
        }
        if (!connectPromise) {
            connectPromise = qz.websocket.connect().catch(function(err) {
                // Fallback to insecure connection if secure fails.
                return qz.websocket.connect({ usingSecure: false });
            }).catch(function(err) {
                connectPromise = null;
                throw err;
            });
        }
        return connectPromise;
    }

    function getDefaultPrinter() {
        return qz.printers.getDefault();
    }

    function resolvePrinter(name) {
        if (!name) {
            return getDefaultPrinter();
        }
        return qz.printers.find(name).catch(function() {
            return getDefaultPrinter();
        });
    }

    function printPdfBase64(base64, options) {
        options = options || {};
        return connect()
            .then(function() {
                return resolvePrinter(options.printer);
            })
            .then(function(printer) {
                var configOptions = {
                    copies: options.copies || 1,
                    margins: { top: 0, right: 0, bottom: 0, left: 0 },
                    scaleContent: false
                };

                if (options.widthMm && options.heightMm) {
                    configOptions.units = 'mm';
                    configOptions.size = {
                        width: options.widthMm,
                        height: options.heightMm
                    };
                }

                var config = qz.configs.create(printer, configOptions);

                var data = [{
                    type: 'pixel',
                    format: 'pdf',
                    flavor: 'base64',
                    data: base64
                }];

                return qz.print(config, data);
            });
    }

    function printLabelsFromForm(formSelector) {
        return connect()
            .then(function() {
                return $.ajax({
                    method: 'POST',
                    url: base_path + '/labels/qz-pdf',
                    dataType: 'json',
                    data: $(formSelector).serialize()
                });
            })
            .then(function(result) {
                if (!result.success) {
                    throw new Error(result.msg || 'Label print failed');
                }
                var printerName = null;
                if (window.APP && APP.QZ_LABEL_PRINTER) {
                    printerName = APP.QZ_LABEL_PRINTER;
                }

                return printPdfBase64(result.data.pdf, {
                    widthMm: result.data.width_mm,
                    heightMm: result.data.height_mm,
                    printer: printerName
                });
            });
    }

    function printLabelsFromData(formData) {
        return connect()
            .then(function() {
                return $.ajax({
                    method: 'POST',
                    url: base_path + '/labels/qz-pdf',
                    dataType: 'json',
                    data: formData
                });
            })
            .then(function(result) {
                if (!result.success) {
                    throw new Error(result.msg || 'Label print failed');
                }
                var printerName = null;
                if (window.APP && APP.QZ_LABEL_PRINTER) {
                    printerName = APP.QZ_LABEL_PRINTER;
                }

                return printPdfBase64(result.data.pdf, {
                    widthMm: result.data.width_mm,
                    heightMm: result.data.height_mm,
                    printer: printerName
                });
            });
    }

    function printTestLines(barcodeSettingId) {
        return connect()
            .then(function() {
                return $.ajax({
                    method: 'POST',
                    url: base_path + '/labels/qz-test-lines',
                    dataType: 'json',
                    data: { barcode_setting: barcodeSettingId }
                });
            })
            .then(function(result) {
                if (!result.success) {
                    throw new Error(result.msg || 'Test print failed');
                }

                var printerName = null;
                if (window.APP && APP.QZ_LABEL_PRINTER) {
                    printerName = APP.QZ_LABEL_PRINTER;
                }

                return printPdfBase64(result.data.pdf, {
                    widthMm: result.data.width_mm,
                    heightMm: result.data.height_mm,
                    printer: printerName
                });
            });
    }

    function mmToDots(mm, dpi) {
        return Math.round((mm * dpi) / 25.4);
    }

    function printTsplTestLines(barcodeSettingId) {
        return connect()
            .then(function() {
                return $.ajax({
                    method: 'POST',
                    url: base_path + '/labels/qz-tspl-config',
                    dataType: 'json',
                    data: { barcode_setting: barcodeSettingId }
                });
            })
            .then(function(result) {
                if (!result.success) {
                    throw new Error(result.msg || 'TSPL test failed');
                }

                var printerName = null;
                if (window.APP && APP.QZ_LABEL_PRINTER) {
                    printerName = APP.QZ_LABEL_PRINTER;
                }

                var dpi = 203;
                if (window.APP && APP.QZ_LABEL_DPI) {
                    dpi = parseInt(APP.QZ_LABEL_DPI, 10) || 203;
                }

                var widthMm = parseFloat(result.data.width_mm);
                var heightMm = parseFloat(result.data.height_mm);
                var gapMm = parseFloat(result.data.gap_mm);

                var widthDots = mmToDots(widthMm, dpi);
                var heightDots = mmToDots(heightMm, dpi);
                var lineGapDots = Math.max(1, mmToDots(1, dpi));

                var cmds = [];
                cmds.push('SIZE ' + widthMm + ' mm,' + heightMm + ' mm');
                cmds.push('GAP ' + gapMm + ' mm,0');
                cmds.push('DIRECTION 1');
                cmds.push('REFERENCE 0,0');
                cmds.push('CLS');
                for (var y = 0; y < heightDots; y += lineGapDots) {
                    cmds.push('LINE 0,' + y + ',' + (widthDots - 1) + ',' + y + ',1');
                }
                cmds.push('PRINT 1,1');

                var data = cmds.join('\r\n') + '\r\n';
                return resolvePrinter(printerName).then(function(printer) {
                    var config = qz.configs.create(printer, { copies: 1 });

                    return qz.print(config, [{
                        type: 'raw',
                        format: 'command',
                        data: data
                    }]);
                });
            });
    }

    window.qzHelper = {
        connect: connect,
        printPdfBase64: printPdfBase64,
        printLabelsFromForm: printLabelsFromForm,
        printLabelsFromData: printLabelsFromData,
        printTestLines: printTestLines,
        printTsplTestLines: printTsplTestLines
    };
})(window, window.jQuery);
