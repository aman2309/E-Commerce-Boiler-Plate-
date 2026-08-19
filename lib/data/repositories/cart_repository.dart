import 'package:flutter_boilerplate/data/models/cart_item_model.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';

class CartRepository {
  final ApiProvider _apiProvider;

  CartRepository(this._apiProvider);

  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await _apiProvider.getCart();
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<CartItemModel> addToCart(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.addToCart(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final itemData = resData['data'] ?? resData;
        return CartItemModel.fromJson(Map<String, dynamic>.from(itemData as Map));
      }
      throw Exception('Invalid response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<CartItemModel> updateCart(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.updateCartItem(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final itemData = resData['data'] ?? resData;
        return CartItemModel.fromJson(Map<String, dynamic>.from(itemData as Map));
      }
      throw Exception('Invalid response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> removeFromCart(String id) async {
    try {
      await _apiProvider.removeFromCart(id);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<Map<String, dynamic>> applyCoupon(String code) async {
    try {
      final response = await _apiProvider.applyCoupon(code);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      return {};
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
