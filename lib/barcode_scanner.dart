import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'add_product_screen.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanned = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned && mounted) {
        scanned = true;
        controller.pauseCamera();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AddProductScreen(barcode: scanData.code ?? ''),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Barkod Tara")),
      body: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
    );
  }
}
