class Product {
  final String id;
  final String name;
  final ProductData? data;
  final String? imagePath; // Added field for image path

  Product({
    required this.id,
    required this.name,
    this.data,
    this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? 'NA',
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      imagePath: 'assets/images/${json['id']}.jpg', // Dynamic image path
    );
  }
}

class ProductData {
  final String? color;
  final String? capacity;
  final double? price;
  final String? generation;
  final int? year;

  ProductData({
    this.color,
    this.capacity,
    this.price,
    this.generation,
    this.year,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      color: json['color']?.toString() ?? json['Color']?.toString(),
      capacity: json['capacity']?.toString() ??
          json['Capacity']?.toString() ??
          json['capacity GB']?.toString(),
      price: json['price'] != null
          ? (json['price'] as num).toDouble()
          : json['Price'] != null
              ? (double.tryParse(json['Price'].toString()) ?? 0.0)
              : null,
      generation: json['generation']?.toString() ?? json['Generation']?.toString(),
      year: json['year'] ?? 0,
    );
  }
}