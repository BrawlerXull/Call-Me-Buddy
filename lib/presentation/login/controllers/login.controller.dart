import 'package:callmebuddy/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void handleLogin() {
    Get.toNamed(Routes.OTP);
  }
}
