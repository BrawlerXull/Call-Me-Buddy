import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';
import 'package:callmebuddy/presentation/login/controllers/login.controller.dart';
import 'package:callmebuddy/infrastructure/navigation/routes.dart';

class OtpController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final RxBool isLoading = false.obs;
  final TextEditingController otpController = TextEditingController();

  void verifyOtp() async {
    isLoading.value = true;
    if (kDebugMode) {
      print("🔵 [OtpController] Verifying OTP...");
    }

    try {
      LoginController loginController = Get.find<LoginController>();
      String enteredOtp = otpController.text.trim();
      String verificationId = loginController.verificationId.value;

      if (kDebugMode) {
        print("🟡 [OtpController] Entered OTP: $enteredOtp");
      }
      if (kDebugMode) {
        print("🟡 [OtpController] Using Verification ID: $verificationId");
      }

      await _authRepository.signInWithCredential(verificationId, enteredOtp);

      if (kDebugMode) {
        print("✅ [OtpController] OTP verification successful. Navigating to HOME...");
      }
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      if (kDebugMode) {
        print("❌ [OtpController] OTP verification failed: $e");
      }
      Get.snackbar("Error", "Invalid OTP");
    }

    isLoading.value = false;
    if (kDebugMode) {
      print("⚪ [OtpController] OTP verification process completed.");
    }
  }
}
