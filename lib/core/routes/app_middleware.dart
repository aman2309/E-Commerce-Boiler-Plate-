import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/core/storage/local_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final token = LocalStorageService.to.getToken();
    final isOnboarded = LocalStorageService.to.isOnboarded();

    if (!isOnboarded) {
      return const RouteSettings(name: AppRoutes.onboarding);
    }

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null;
  }
}
