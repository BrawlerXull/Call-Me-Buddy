import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';
import 'package:callmebuddy/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final RxBool isLoading = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  RxString verificationId = ''.obs;

  void handleLogin() async {
    isLoading.value = true;
    if (kDebugMode) {
      print("🔵 [LoginController] Initiating phone number verification...");
    }

    try {
      String phoneNumber = phoneController.text.trim();

      if (kDebugMode) {
        print("🟡 [LoginController] Phone number entered: $phoneNumber");
      }

      await _authRepository.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (String uid) {
          if (kDebugMode) {
            print("✅ [LoginController] Auto verification successful. UID: $uid");
          }
          Get.offAllNamed(Routes.HOME);
        },
        verificationFailed: (String error) {
          if (kDebugMode) {
            print("❌ [LoginController] Verification failed: $error");
          }
          Get.snackbar("Error", error);
        },
        codeSent: (String verId) {
          verificationId.value = verId;
          if (kDebugMode) {
            print("🟢 [LoginController] OTP code sent. Verification ID: $verId");
          }
          Get.toNamed(Routes.OTP);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
          if (kDebugMode) {
            print("⏳ [LoginController] Auto-retrieval timeout. Verification ID: $verId");
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("❌ [LoginController] Unexpected error during login: $e");
      }
      Get.snackbar("Error", "Something went wrong");
    }

    isLoading.value = false;
    if (kDebugMode) {
      print("⚪ [LoginController] Phone number verification process completed.");
    }
  }
}
