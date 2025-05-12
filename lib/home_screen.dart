import 'package:flutter/material.dart';
import 'barcode_scanner.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alira Cafe Stok")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BarcodeScanner()),
                );
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text("Ürün Ekle / Güncelle"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductListScreen()),
                );
              },
              icon: const Icon(Icons.list),
              label: const Text("Ürün Listesi"),
            ),
          ],
        ),
      ),
    );
  }
}
