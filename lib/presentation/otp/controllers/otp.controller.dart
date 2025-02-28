import 'package:callmebuddy/presentation/login/controllers/login.controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';

import 'package:callmebuddy/infrastructure/navigation/routes.dart';

class OtpController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final RxBool isLoading = false.obs;
  final TextEditingController otpController = TextEditingController();

  void verifyOtp() async {
    isLoading.value = true;
    try {
      LoginController loginController = Get.find<LoginController>();

      await _authRepository.signInWithCredential(
        loginController.verificationId.value,
        otpController.text.trim(),
      );

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP");
    }
    isLoading.value = false;
  }
}
