import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final isLoading = false.obs;
  final selectedSubject = 'General Inquiry'.obs;

  final subjects = [
    'General Inquiry',
    'Order Issue',
    'Return & Refund',
    'Product Question',
    'Account Issue',
    'Technical Support',
    'Feedback',
    'Other',
  ];

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  Future<void> sendMessage() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all required fields',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    selectedSubject.value = 'General Inquiry';

    Get.snackbar('Message Sent', 'We will get back to you within 24 hours',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> callSupport() async {
    final uri = Uri(scheme: 'tel', path: '+18001234567');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch phone dialer',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> emailSupport() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@flutterboilerplate.com',
      query: 'subject=Support Request',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch email client',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> openMap() async {
    final uri = Uri.parse(
      'https://maps.google.com/?q=123+Main+Street,+New+York,+NY+10001',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not open map', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> openSocialLink(String platform) async {
    final urls = {
      'facebook': 'https://facebook.com/flutterboilerplate',
      'instagram': 'https://instagram.com/flutterboilerplate',
      'twitter': 'https://twitter.com/flutterboilerplate',
      'youtube': 'https://youtube.com/@flutterboilerplate',
    };

    final url = urls[platform];
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
