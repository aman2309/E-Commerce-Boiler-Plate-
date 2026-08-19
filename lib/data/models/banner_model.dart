class BannerModel {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? productId;

  const BannerModel({
    required this.id,
    required this.imageUrl,
    this.title = '',
    this.subtitle = '',
    this.productId,
  });

  bool get hasNavigation => productId != null && productId!.isNotEmpty;

  BannerModel copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? subtitle,
    String? productId,
    bool clearProductId = false,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      productId: clearProductId ? null : (productId ?? this.productId),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'productId': productId,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      productId: json['productId']?.toString(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'BannerModel(id: $id, title: $title)';
}
