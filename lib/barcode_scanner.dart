import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/material.dart';
import 'dart:io' show Platform; // Web'de çalışmaz, dikkatli kullan

import 'mobile_scanner_screen.dart'; // Mobil tarayıcı
import 'web_scanner_screen.dart'; // Web tarayıcı (az sonra yazacağız)

class BarcodeScanner extends StatelessWidget {
  const BarcodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const WebScannerScreen(); // Web için özel ekran
    } else if (Platform.isAndroid || Platform.isIOS) {
      return const MobileScannerScreen(); // Mevcut kod buraya taşınacak
    } else {
      return const Scaffold(
        body: Center(child: Text("Bu platformda desteklenmiyor.")),
      );
    }
  }
}
