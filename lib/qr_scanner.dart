import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:mi_gente/utils/strings.dart';

class QrScannerPage extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Lector de QR',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Por favor coloca el QR en el area',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(height: 16),
                    Text('El escaneado iniciará automaticamente',
                        style: TextStyle(color: Colors.black54, fontSize: 16)),
                  ],
                )),
                Expanded(
                    flex: 4,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) {
                        _onQRViewCreated(controller, context);
                      },
                      overlay: QrScannerOverlayShape(
                          overlayColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          borderColor: Colors.indigo,
                          borderRadius: 8,
                          borderLength: 20,
                          borderWidth: 8,
                          cutOutSize: scanArea),
                    )),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'by @christhoval',
                    style: TextStyle(
                        color: Colors.black87, fontSize: 14, letterSpacing: 1),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    controller.scannedDataStream.listen((scanData) {
      Barcode? result = scanData;

      String? code = result.code;
      List<String>? ndiData = code?.decompileNdi();
      if (ndiData != null && result.format == BarcodeFormat.qrcode) {
        controller.dispose();
        Navigator.pop(context, code);
      }
    });
  }
}
