import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/core/routes/app_bindings.dart';
import 'package:flutter_boilerplate/modules/splash/splash_view.dart';
import 'package:flutter_boilerplate/modules/onboarding/onboarding_view.dart';
import 'package:flutter_boilerplate/modules/auth/login/login_view.dart';
import 'package:flutter_boilerplate/modules/auth/signup/signup_view.dart';
import 'package:flutter_boilerplate/modules/auth/forgot_password/forgot_password_view.dart';
import 'package:flutter_boilerplate/modules/auth/otp/otp_view.dart';
import 'package:flutter_boilerplate/modules/home/main_view.dart';
import 'package:flutter_boilerplate/modules/products/product_listing_view.dart';
import 'package:flutter_boilerplate/modules/products/product_details_view.dart';
import 'package:flutter_boilerplate/modules/products/categories/categories_view.dart';
import 'package:flutter_boilerplate/modules/cart/cart_view.dart';
import 'package:flutter_boilerplate/modules/wishlist/wishlist_view.dart';
import 'package:flutter_boilerplate/modules/checkout/checkout_view.dart';
import 'package:flutter_boilerplate/modules/checkout/address/add_address_view.dart';
import 'package:flutter_boilerplate/modules/orders/orders_view.dart';
import 'package:flutter_boilerplate/modules/orders/order_details/order_details_view.dart';
import 'package:flutter_boilerplate/modules/profile/profile_view.dart';
import 'package:flutter_boilerplate/modules/settings/settings_view.dart';
import 'package:flutter_boilerplate/modules/notifications/notifications_view.dart';
import 'package:flutter_boilerplate/modules/contact_us/contact_us_view.dart';
import 'package:flutter_boilerplate/modules/products/search/search_view.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductListingView(),
      binding: ProductListingBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: '/not-found',
    page: () => const Scaffold(
      body: Center(child: Text('Page not found')),
    ),
  );
}
