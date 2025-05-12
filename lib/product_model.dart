class Product {
  int? id;
  String name;
  String barcode;
  int quantity;
  String createdAt;
  String? updatedAt;

  Product({
    this.id,
    required this.name,
    required this.barcode,
    required this.quantity,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'quantity': quantity,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      barcode: map['barcode'],
      quantity: map['quantity'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
