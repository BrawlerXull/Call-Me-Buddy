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
    try {
      await _authRepository.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim(),
        verificationCompleted: (String uid) {
          Get.offAllNamed(Routes.HOME);
        },
        verificationFailed: (String error) {
          Get.snackbar("Error", error);
        },
        codeSent: (String verId) {
          verificationId.value = verId;
          Get.toNamed(Routes.OTP);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
    isLoading.value = false;
  }
}
