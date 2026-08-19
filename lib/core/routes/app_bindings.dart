import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/modules/splash/splash_controller.dart';
import 'package:flutter_boilerplate/modules/onboarding/onboarding_controller.dart';
import 'package:flutter_boilerplate/modules/auth/login/login_controller.dart';
import 'package:flutter_boilerplate/modules/auth/signup/signup_controller.dart';
import 'package:flutter_boilerplate/modules/auth/forgot_password/forgot_password_controller.dart';
import 'package:flutter_boilerplate/modules/auth/otp/otp_controller.dart';
import 'package:flutter_boilerplate/modules/home/home_controller.dart';
import 'package:flutter_boilerplate/modules/home/main_controller.dart';
import 'package:flutter_boilerplate/modules/products/product_listing_controller.dart';
import 'package:flutter_boilerplate/modules/products/product_details_controller.dart';
import 'package:flutter_boilerplate/modules/products/categories/categories_controller.dart';
import 'package:flutter_boilerplate/modules/products/search/search_controller.dart';
import 'package:flutter_boilerplate/modules/cart/cart_controller.dart';
import 'package:flutter_boilerplate/modules/wishlist/wishlist_controller.dart';
import 'package:flutter_boilerplate/modules/checkout/checkout_controller.dart';
import 'package:flutter_boilerplate/modules/checkout/address/add_address_controller.dart';
import 'package:flutter_boilerplate/modules/orders/orders_controller.dart';
import 'package:flutter_boilerplate/modules/orders/order_details/order_details_controller.dart';
import 'package:flutter_boilerplate/modules/profile/profile_controller.dart';
import 'package:flutter_boilerplate/modules/settings/settings_controller.dart';
import 'package:flutter_boilerplate/modules/notifications/notifications_controller.dart';
import 'package:flutter_boilerplate/modules/contact_us/contact_us_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    if (AppConfig.demoMode) {
      Get.lazyPut<LoginController>(() => LoginController());
    } else {
      Get.lazyPut<LoginController>(() => LoginController(Get.find()));
    }
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    Get.lazyPut<WishlistController>(() => WishlistController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class ProductListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListingController>(() => ProductListingController());
  }
}

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  }
}

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppSearchController>(() => AppSearchController());
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(() => WishlistController());
  }
}

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}

class AddAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressController>(() => AddAddressController());
  }
}

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }
}
