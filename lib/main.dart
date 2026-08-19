import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/localization/app_translations.dart';
import 'package:flutter_boilerplate/core/network/api_client.dart';
import 'package:flutter_boilerplate/core/routes/app_pages.dart';
import 'package:flutter_boilerplate/core/routes/app_routes.dart';
import 'package:flutter_boilerplate/core/storage/local_storage.dart';
import 'package:flutter_boilerplate/core/theme/app_theme.dart';
import 'package:flutter_boilerplate/data/providers/api_provider.dart';
import 'package:flutter_boilerplate/data/repositories/auth_repository.dart';
import 'package:flutter_boilerplate/data/repositories/cart_repository.dart';
import 'package:flutter_boilerplate/data/repositories/order_repository.dart';
import 'package:flutter_boilerplate/data/repositories/product_repository.dart';
import 'package:flutter_boilerplate/data/repositories/profile_repository.dart';
import 'package:flutter_boilerplate/services/connectivity_service.dart';
import 'package:flutter_boilerplate/services/notification_service.dart';
import 'package:flutter_boilerplate/services/storage_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    final apiClient = Get.find<ApiClient>();
    final apiProvider = ApiProvider(apiClient);

    Get.lazyPut(() => apiProvider, fenix: true);
    Get.lazyPut(() => ProductRepository(apiProvider), fenix: true);
    Get.lazyPut(() => AuthRepository(apiProvider, Get.find()), fenix: true);
    Get.lazyPut(() => CartRepository(apiProvider), fenix: true);
    Get.lazyPut(() => OrderRepository(apiProvider), fenix: true);
    Get.lazyPut(() => ProfileRepository(apiProvider), fenix: true);
    Get.lazyPut(() => NotificationService(), fenix: true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  await storageService.init();
  Get.put(storageService);

  final localStorageService = LocalStorageService();
  await localStorageService.init();
  Get.put(localStorageService);

  final apiClient = ApiClient();
  apiClient.init();
  Get.put(apiClient);

  Get.put(ConnectivityService());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      debugPrint('Flutter Error: ${details.exception}');
    }
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    final themeMode = storageService.getThemeMode();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: kDebugMode && AppConfig.enableDebugBanner,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          initialRoute: AppRoutes.splash,
          initialBinding: AppBindings(),
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,
          defaultTransition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
          translations: AppTranslations(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
