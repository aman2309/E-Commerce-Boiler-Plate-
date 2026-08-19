import 'package:flutter_boilerplate/data/models/order_item_model.dart';

enum OrderStatus {
  placed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled;

  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Placed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.placed:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipped:
        return 2;
      case OrderStatus.outForDelivery:
        return 3;
      case OrderStatus.delivered:
        return 4;
      case OrderStatus.cancelled:
        return 0;
    }
  }

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.placed,
    );
  }
}

class OrderModel {
  final String id;
  final String orderNumber;
  final DateTime date;
  final OrderStatus status;
  final List<OrderItem> items;
  final double subtotal;
  final double discount;
  final double deliveryCharge;
  final double tax;
  final double total;
  final String shippingAddress;
  final String paymentMethod;
  final String trackingNumber;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    this.items = const [],
    this.subtotal = 0.0,
    this.discount = 0.0,
    this.deliveryCharge = 0.0,
    this.tax = 0.0,
    this.total = 0.0,
    this.shippingAddress = '',
    this.paymentMethod = '',
    this.trackingNumber = '',
  });

  bool get canCancel =>
      status == OrderStatus.placed || status == OrderStatus.processing;

  bool get isTrackable =>
      status == OrderStatus.shipped || status == OrderStatus.outForDelivery;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    DateTime? date,
    OrderStatus? status,
    List<OrderItem>? items,
    double? subtotal,
    double? discount,
    double? deliveryCharge,
    double? tax,
    double? total,
    String? shippingAddress,
    String? paymentMethod,
    String? trackingNumber,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      date: date ?? this.date,
      status: status ?? this.status,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'date': date.toIso8601String(),
      'status': status.name,
      'items': items.map((i) => i.toJson()).toList(),
      'subtotal': subtotal,
      'discount': discount,
      'deliveryCharge': deliveryCharge,
      'tax': tax,
      'total': total,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'trackingNumber': trackingNumber,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      orderNumber: json['orderNumber']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
      status: OrderStatus.fromString(json['status']?.toString() ?? 'placed'),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      shippingAddress: json['shippingAddress']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      trackingNumber: json['trackingNumber']?.toString() ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'OrderModel(id: $id, orderNumber: $orderNumber, status: ${status.name})';
}
