import 'package:flutter_boilerplate/data/models/product_model.dart';
import 'package:flutter_boilerplate/data/models/category_model.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';

class ExceptionHandler {
  static String getMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return error.toString();
  }
}

class ProductRepository {
  final ApiProvider _apiProvider;

  ProductRepository(this._apiProvider);

  Future<List<ProductModel>> getProducts({Map<String, dynamic>? params}) async {
    try {
      final response = await _apiProvider.getProducts(params);
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(ExceptionHandler.getMessage(e));
    }
  }

  Future<ProductModel> getProductDetails(String id) async {
    try {
      final response = await _apiProvider.getProduct(id);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final productData = data['data'] ?? data;
        return ProductModel.fromJson(Map<String, dynamic>.from(productData as Map));
      }
      throw Exception('Invalid product data');
    } catch (e) {
      throw Exception(ExceptionHandler.getMessage(e));
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _apiProvider.searchProducts(query);
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(ExceptionHandler.getMessage(e));
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiProvider.getCategories();
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(ExceptionHandler.getMessage(e));
    }
  }
}
