import 'package:flutter_boilerplate/data/models/user_model.dart';
import 'package:flutter_boilerplate/data/models/address_model.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';

class ProfileRepository {
  final ApiProvider _apiProvider;

  ProfileRepository(this._apiProvider);

  Future<UserModel> getProfile() async {
    try {
      final response = await _apiProvider.getProfile();
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final profileData = data['data'] ?? data;
        return UserModel.fromJson(Map<String, dynamic>.from(profileData as Map));
      }
      throw Exception('Invalid profile data');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.updateProfile(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final profileData = resData['data'] ?? resData;
        return UserModel.fromJson(Map<String, dynamic>.from(profileData as Map));
      }
      throw Exception('Invalid profile response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _apiProvider.getAddresses();
      final data = response.data;
      if (data is Map<String, dynamic> && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      if (data is List) {
        return data
            .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<AddressModel> addAddress(Map<String, dynamic> data) async {
    try {
      final response = await _apiProvider.addAddress(data);
      final resData = response.data;
      if (resData is Map<String, dynamic>) {
        final addressData = resData['data'] ?? resData;
        return AddressModel.fromJson(Map<String, dynamic>.from(addressData as Map));
      }
      throw Exception('Invalid address response');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
