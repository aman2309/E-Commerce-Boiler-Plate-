class CartItemModel {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String size;
  final String color;
  final String variant;

  const CartItemModel({
    required this.productId,
    required this.name,
    this.image = '',
    required this.price,
    this.quantity = 1,
    this.size = '',
    this.color = '',
    this.variant = '',
  });

  double get totalPrice => price * quantity;

  String get variantLabel {
    final parts = <String>[];
    if (size.isNotEmpty) parts.add('Size: $size');
    if (color.isNotEmpty) parts.add('Color: $color');
    if (variant.isNotEmpty) parts.add(variant);
    return parts.join(' | ');
  }

  CartItemModel copyWith({
    String? productId,
    String? name,
    String? image,
    double? price,
    int? quantity,
    String? size,
    String? color,
    String? variant,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
      variant: variant ?? this.variant,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'size': size,
      'color': color,
      'variant': variant,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      size: json['size']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      variant: json['variant']?.toString() ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          size == other.size &&
          color == other.color;

  @override
  int get hashCode => Object.hash(productId, size, color);

  @override
  String toString() => 'CartItemModel(productId: $productId, name: $name, qty: $quantity)';
}
