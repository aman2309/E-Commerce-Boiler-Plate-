import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String brand;
  final String categoryId;
  final double price;
  final double salePrice;
  final double discount;
  final double rating;
  final int reviewCount;
  final int stock;
  final String sku;
  final List<String> images;
  final List<String> sizes;
  final List<Map<String, dynamic>> colors;
  final Map<String, String> specifications;
  final bool isWishlisted;
  final bool isInCart;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    this.brand = '',
    this.categoryId = '',
    required this.price,
    this.salePrice = 0.0,
    this.discount = 0.0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.stock = 0,
    this.sku = '',
    this.images = const [],
    this.sizes = const [],
    this.colors = const [],
    this.specifications = const {},
    this.isWishlisted = false,
    this.isInCart = false,
  });

  bool get hasDiscount => discount > 0 || salePrice > 0 && salePrice < price;
  double get effectivePrice => salePrice > 0 && salePrice < price ? salePrice : price;

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? brand,
    String? categoryId,
    double? price,
    double? salePrice,
    double? discount,
    double? rating,
    int? reviewCount,
    int? stock,
    String? sku,
    List<String>? images,
    List<String>? sizes,
    List<Map<String, dynamic>>? colors,
    Map<String, String>? specifications,
    bool? isWishlisted,
    bool? isInCart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      discount: discount ?? this.discount,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      sku: sku ?? this.sku,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      specifications: specifications ?? this.specifications,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'categoryId': categoryId,
      'price': price,
      'salePrice': salePrice,
      'discount': discount,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
      'sku': sku,
      'images': images,
      'sizes': sizes,
      'colors': colors,
      'specifications': specifications,
      'isWishlisted': isWishlisted,
      'isInCart': isInCart,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      sku: json['sku']?.toString() ?? '',
      images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      sizes: (json['sizes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      colors: (json['colors'] as List<dynamic>?)?.map((e) => Map<String, dynamic>.from(e as Map)).toList() ?? [],
      specifications: (json['specifications'] as Map<String, dynamic>?)?.map((k, v) => MapEntry(k, v.toString())) ?? {},
      isWishlisted: json['isWishlisted'] as bool? ?? false,
      isInCart: json['isInCart'] as bool? ?? false,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory ProductModel.fromJsonString(String jsonString) =>
      ProductModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProductModel(id: $id, name: $name, price: $price)';
}
