import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';

class ApiProvider {
  final ApiClient _client;

  ApiProvider(this._client);

  // ──────────────────── Auth ────────────────────

  Future<Response<dynamic>> login(String email, String password) {
    return _client.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response<dynamic>> signup(Map<String, dynamic> data) {
    return _client.post('/auth/signup', data: data);
  }

  Future<Response<dynamic>> forgotPassword(String email) {
    return _client.post('/auth/forgot-password', data: {'email': email});
  }

  Future<Response<dynamic>> verifyOtp(String otp) {
    return _client.post('/auth/verify-otp', data: {'otp': otp});
  }

  Future<Response<dynamic>> resetPassword(Map<String, dynamic> data) {
    return _client.post('/auth/reset-password', data: data);
  }

  // ──────────────────── Products ────────────────────

  Future<Response<dynamic>> getProducts(Map<String, dynamic>? params) {
    return _client.get('/products', queryParameters: params);
  }

  Future<Response<dynamic>> getProduct(String id) {
    return _client.get('/products/$id');
  }

  Future<Response<dynamic>> searchProducts(String query) {
    return _client.get('/products/search', queryParameters: {'q': query});
  }

  Future<Response<dynamic>> getCategories() {
    return _client.get('/categories');
  }

  // ──────────────────── Cart ────────────────────

  Future<Response<dynamic>> getCart() {
    return _client.get('/cart');
  }

  Future<Response<dynamic>> addToCart(Map<String, dynamic> data) {
    return _client.post('/cart', data: data);
  }

  Future<Response<dynamic>> updateCartItem(Map<String, dynamic> data) {
    return _client.put('/cart', data: data);
  }

  Future<Response<dynamic>> removeFromCart(String id) {
    return _client.delete('/cart/$id');
  }

  Future<Response<dynamic>> applyCoupon(String code) {
    return _client.post('/cart/coupon', data: {'code': code});
  }

  // ──────────────────── Wishlist ────────────────────

  Future<Response<dynamic>> getWishlist() {
    return _client.get('/wishlist');
  }

  Future<Response<dynamic>> addToWishlist(String productId) {
    return _client.post('/wishlist', data: {'productId': productId});
  }

  Future<Response<dynamic>> removeFromWishlist(String productId) {
    return _client.delete('/wishlist/$productId');
  }

  // ──────────────────── Orders ────────────────────

  Future<Response<dynamic>> getOrders() {
    return _client.get('/orders');
  }

  Future<Response<dynamic>> getOrderDetails(String id) {
    return _client.get('/orders/$id');
  }

  Future<Response<dynamic>> createOrder(Map<String, dynamic> data) {
    return _client.post('/orders', data: data);
  }

  Future<Response<dynamic>> cancelOrder(String id) {
    return _client.post('/orders/$id/cancel');
  }

  // ──────────────────── Profile ────────────────────

  Future<Response<dynamic>> getProfile() {
    return _client.get('/profile');
  }

  Future<Response<dynamic>> updateProfile(Map<String, dynamic> data) {
    return _client.put('/profile', data: data);
  }

  Future<Response<dynamic>> getAddresses() {
    return _client.get('/profile/addresses');
  }

  Future<Response<dynamic>> addAddress(Map<String, dynamic> data) {
    return _client.post('/profile/addresses', data: data);
  }

  // ──────────────────── Notifications ────────────────────

  Future<Response<dynamic>> getNotifications() {
    return _client.get('/notifications');
  }

  Future<Response<dynamic>> markNotificationRead(String id) {
    return _client.put('/notifications/$id/read');
  }

  // ──────────────────── Misc ────────────────────

  Future<Response<dynamic>> contactUs(Map<String, dynamic> data) {
    return _client.post('/contact', data: data);
  }
}
