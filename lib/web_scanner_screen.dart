import 'dart:html' as html;
import 'dart:js' as js; // js kütüphanesini ekleyelim
import 'package:flutter/material.dart';

class WebScannerScreen extends StatefulWidget {
  const WebScannerScreen({super.key});

  @override
  State<WebScannerScreen> createState() => _WebScannerScreenState();
}

class _WebScannerScreenState extends State<WebScannerScreen> {
  String? barcode;

  @override
  void initState() {
    super.initState();

    // JavaScript'ten gelecek sonucu dinle
    html.window.addEventListener('zxing-scan-result', (event) {
      final customEvent = event as html.CustomEvent;
      final scannedCode = customEvent.detail;
      setState(() {
        barcode = scannedCode;
      });

      // Tarama sonucu ekrana yazdırılır
      print('Barkod okundu: $scannedCode');
    });

    // JavaScript fonksiyonunu çağırıyoruz
    // 'startZXingScanner' fonksiyonunu js.context.callMethod ile çağırıyoruz
    js.context.callMethod('startZXingScanner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web Barkod Tarayıcı")),
      body: Column(
        children: [
          // HTML video elementini Flutter widget'ına gömme
          Expanded(child: HtmlElementView(viewType: 'zxing-video-view')),
          if (barcode != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Okunan Barkod: $barcode'),
            ),
        ],
      ),
    );
  }
}
