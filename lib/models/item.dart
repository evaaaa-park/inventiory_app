class Item {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.category = '',
  });

  // Dart object → Firestore document map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'category': category,
    };
  }

  // Firestore document → Dart object
  factory Item.fromMap(String id, Map<String, dynamic> data) {
    return Item(
      id: id,
      name: data['name'] ?? '',
      quantity: (data['quantity'] ?? 0).toInt(),
      price: (data['price'] ?? 0.0).toDouble(),
      category: data['category'] ?? '',
    );
  }
}