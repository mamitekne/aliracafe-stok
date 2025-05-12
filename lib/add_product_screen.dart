import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'product_model.dart';

class AddProductScreen extends StatefulWidget {
  final String barcode;
  final Product? product; // Ürün düzenleme için product parametresi ekledik

  const AddProductScreen({super.key, required this.barcode, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _qtyCtrl = TextEditingController();
  late String _barcode;
  int? _productId;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      // Liste ekranından geldi, düzenleme modu
      final product = widget.product!;
      _productId = product.id;
      _barcode = product.barcode;
      _nameCtrl.text = product.name;
      _qtyCtrl.text = product.quantity.toString();
      _isUpdate = true;
    } else {
      // Barkoddan geldi, yeni ürün veya daha önce kayıtlı olan
      _barcode = widget.barcode;
      _loadProductByBarcode();
    }
  }

  Future<void> _loadProductByBarcode() async {
    final product = await DatabaseHelper.instance.getProductByBarcode(_barcode);
    if (product != null) {
      setState(() {
        _productId = product.id;
        _nameCtrl.text = product.name;
        _qtyCtrl.text = product.quantity.toString();
        _isUpdate = true;
      });
    }
  }

  Future<void> _saveProduct() async {
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final product = Product(
      id: _productId,
      name: _nameCtrl.text,
      barcode: _barcode,
      quantity: int.tryParse(_qtyCtrl.text) ?? 0,
      createdAt: _isUpdate ? widget.product?.createdAt ?? now : now,
      updatedAt: now,
    );

    if (_isUpdate) {
      await DatabaseHelper.instance.updateProduct(product);
    } else {
      await DatabaseHelper.instance.insertProduct(product);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Bilgileri")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Barkod: $_barcode", style: const TextStyle(fontSize: 16)),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: "Ürün Adı"),
                validator: (val) => val!.isEmpty ? "Boş bırakılamaz" : null,
              ),
              TextFormField(
                controller: _qtyCtrl,
                decoration: const InputDecoration(labelText: "Adet"),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty ? "Boş bırakılamaz" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProduct();
                  }
                },
                child: Text(_isUpdate ? "Güncelle" : "Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
