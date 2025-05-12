import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_model.dart';
import 'add_product_screen.dart'; // AddProductScreen import edildi

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

  // Ürünleri yüklemek için veritabanı sorgusu
  Future<void> _loadProducts() async {
    final data = await DatabaseHelper.instance.getAllProducts();
    setState(() {
      _products = data;
    });
  }

  // Ürün silme fonksiyonu
  Future<void> _deleteProduct(int id) async {
    await DatabaseHelper.instance.deleteProduct(id);
    _loadProducts();
  }

  // Sayfa yüklendiğinde ürünleri çekme
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Listesi")),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (_, i) {
          final p = _products[i];
          return Card(
            child: ListTile(
              title: Text(p.name),
              subtitle: Text("Adet: ${p.quantity}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ürün silme butonu
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(p.id!),
                  ),
                  // Grafik butonu (Ürünle ilgili grafik açılacak)
                  IconButton(
                    icon: const Icon(Icons.bar_chart, color: Colors.blue),
                    onPressed: () {
                      // Grafik widget'ını açma
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddProductScreen(
                                barcode: p.barcode,
                                product: p,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Ürün düzenleme işlemi için tıklama
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AddProductScreen(barcode: p.barcode, product: p),
                  ),
                );
                _loadProducts(); // Listeyi yenile
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni ürün eklemek için AddProductScreen'e gitme
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(barcode: ""),
            ),
          );
        },
        tooltip: 'Yeni Ürün Ekle',
        child: const Icon(Icons.add), // 'child' son parametre olarak taşındı
      ),
    );
  }
}
