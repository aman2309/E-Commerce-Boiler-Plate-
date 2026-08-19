class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final int color;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    this.icon = '',
    this.color = 0xFF6C63FF,
    this.productCount = 0,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? icon,
    int? color,
    int? productCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'productCount': productCount,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      icon: json['icon']?.toString() ?? '',
      color: (json['color'] as num?)?.toInt() ?? 0xFF6C63FF,
      productCount: (json['productCount'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, productCount: $productCount)';
}
