import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnection();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final wasConnected = isConnected.value;
    isConnected.value = results.any((r) => r != ConnectivityResult.none);

    if (wasConnected && !isConnected.value) {
      _showSnackBar(
        'No Internet Connection',
        'Please check your internet settings.',
        Icons.wifi_off_rounded,
        Colors.red,
      );
    } else if (!wasConnected && isConnected.value) {
      _showSnackBar(
        'Back Online',
        'Internet connection restored.',
        Icons.wifi_rounded,
        Colors.green,
      );
    }
  }

  void _showSnackBar(String title, String message, IconData icon, Color color) {
    if (Get.overlayContext == null) return;
    Get.snackbar(
      title,
      message,
      icon: Icon(icon, color: Colors.white),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: color,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
