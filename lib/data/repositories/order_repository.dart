import 'package:flutter_boilerplate/data/models/order_model.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';

class OrderRepository {
  final ApiProvider _apiProvider;

  OrderRepository(this._apiProvider);

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await _apiProvider.getOrders();
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<OrderModel> getOrderDetails(String id) async {
    try {
      final response = await _apiProvider.getOrderDetails(id);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final orderData = data['data'] ?? data;
        return OrderModel.fromJson(Map<String, dynamic>.from(orderData as Map));
      }
      throw Exception('Invalid order data');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<OrderModel> createOrder(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.createOrder(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final orderData = resData['data'] ?? resData;
        return OrderModel.fromJson(Map<String, dynamic>.from(orderData as Map));
      }
      throw Exception('Invalid order response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> cancelOrder(String id) async {
    try {
      await _apiProvider.cancelOrder(id);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
