class Product {
  final int id;
  final String title;
  final double price;
  final double rating;
  final String thumbnail;
  final String description;
  final String category;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.description,
    required this.category,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
    );
  }
}