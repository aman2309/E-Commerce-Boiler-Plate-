class OrderItem {
  final String productId;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String variant;
  final String size;
  final String color;

  const OrderItem({
    required this.productId,
    required this.name,
    this.image = '',
    required this.price,
    required this.quantity,
    this.variant = '',
    this.size = '',
    this.color = '',
  });

  double get totalPrice => price * quantity;

  String get variantLabel {
    final parts = <String>[];
    if (size.isNotEmpty) parts.add('Size: $size');
    if (color.isNotEmpty) parts.add('Color: $color');
    if (variant.isNotEmpty) parts.add(variant);
    return parts.join(' | ');
  }

  OrderItem copyWith({
    String? productId,
    String? name,
    String? image,
    double? price,
    int? quantity,
    String? variant,
    String? size,
    String? color,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'variant': variant,
      'size': size,
      'color': color,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      variant: json['variant']?.toString() ?? '',
      size: json['size']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          size == other.size &&
          color == other.color;

  @override
  int get hashCode => Object.hash(productId, size, color);

  @override
  String toString() => 'OrderItem(productId: $productId, name: $name, qty: $quantity)';
}
