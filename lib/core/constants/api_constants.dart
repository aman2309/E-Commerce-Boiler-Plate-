class ApiConstants {
  ApiConstants._();

  static const String apiVersion = '/api/v1';

  // Auth
  static const String login = '$apiVersion/auth/login';
  static const String signup = '$apiVersion/auth/signup';
  static const String forgotPassword = '$apiVersion/auth/forgot-password';
  static const String verifyOtp = '$apiVersion/auth/verify-otp';
  static const String resetPassword = '$apiVersion/auth/reset-password';
  static const String refreshToken = '$apiVersion/auth/refresh-token';
  static const String logout = '$apiVersion/auth/logout';

  // Products
  static const String products = '$apiVersion/products';
  static String productDetails(String id) => '$apiVersion/products/$id';
  static const String productSearch = '$apiVersion/products/search';
  static const String categories = '$apiVersion/categories';

  // Cart
  static const String cart = '$apiVersion/cart';
  static const String cartAdd = '$apiVersion/cart/add';
  static String cartUpdate(String itemId) => '$apiVersion/cart/$itemId';
  static String cartRemove(String itemId) => '$apiVersion/cart/$itemId';
  static const String applyCoupon = '$apiVersion/cart/coupon';

  // Wishlist
  static const String wishlist = '$apiVersion/wishlist';
  static const String wishlistAdd = '$apiVersion/wishlist/add';
  static String wishlistRemove(String productId) => '$apiVersion/wishlist/$productId';

  // Orders
  static const String orders = '$apiVersion/orders';
  static String orderDetails(String id) => '$apiVersion/orders/$id';
  static const String createOrder = '$apiVersion/orders/create';
  static String cancelOrder(String id) => '$apiVersion/orders/$id/cancel';
  static String reorder(String id) => '$apiVersion/orders/$id/reorder';

  // User
  static const String userProfile = '$apiVersion/user/profile';
  static const String updateProfile = '$apiVersion/user/profile';
  static const String addresses = '$apiVersion/user/addresses';
  static const String notifications = '$apiVersion/user/notifications';

  // Contact
  static const String contact = '$apiVersion/contact';
}
