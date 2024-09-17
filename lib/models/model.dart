// models/product_model.dart
class Product {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String unit;
  final String image;
  final double discount;
  final bool availability;
  final String brand;
  final String category;
  final double rating;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.image,
    required this.discount,
    required this.availability,
    required this.brand,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      unit: json['unit'],
      image: json['image'], // Random image
      discount: json['discount'].toDouble(),
      availability: json['availability'],
      brand: json['brand'],
      category: json['category'],
      rating: json['rating'].toDouble(),
    );
  }
}
