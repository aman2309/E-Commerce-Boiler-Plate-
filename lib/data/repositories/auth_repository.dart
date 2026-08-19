import 'package:flutter_boilerplate/data/models/user_model.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';
import 'package:flutter_boilerplate/services/storage_service.dart';

class AuthRepository {
  final ApiProvider _apiProvider;
  final StorageService _storageService;

  AuthRepository(this._apiProvider, this._storageService);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _apiProvider.login(email, password);
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final token = data['token']?.toString();
        final userData = data['data'] ?? data['user'];
        if (token != null) {
          await _storageService.saveToken(token);
        }
        if (userData is Map<String, dynamic>) {
          final user = UserModel.fromJson(Map<String, dynamic>.from(userData));
          await _storageService.saveUser(user.toJson());
          return user;
        }
      }
      throw Exception('Invalid login response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<UserModel> signup(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.signup(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final token = resData['token']?.toString();
        final userData = resData['data'] ?? resData['user'];
        if (token != null) {
          await _storageService.saveToken(token);
        }
        if (userData is Map<String, dynamic>) {
          final user = UserModel.fromJson(Map<String, dynamic>.from(userData));
          await _storageService.saveUser(user.toJson());
          return user;
        }
      }
      throw Exception('Invalid signup response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _apiProvider.forgotPassword(email);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      await _apiProvider.verifyOtp(otp);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> resetPassword(Map<String, dynamic> data) async {
    try {
      await _apiProvider.resetPassword(data);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<void> logout() async {
    await _storageService.clearSession();
  }
}
