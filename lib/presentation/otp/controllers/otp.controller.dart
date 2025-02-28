import 'package:callmebuddy/infrastructure/navigation/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:callmebuddy/presentation/login/controllers/login.controller.dart';

class OtpController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verifyOtp() async {
    isLoading.value = true;
    try {
      LoginController loginController = Get.find<LoginController>();
      print("Verification ID: ${loginController.verificationId.value}");
      print("Entered OTP: ${otpController.text.trim()}");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: loginController.verificationId.value,
        smsCode: otpController.text.trim(),
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("User credential received: ${userCredential.user}");

      if (userCredential.user != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Error", "OTP verification failed");
      }
    } catch (e) {
      print("Error during OTP verification: $e");
      Get.snackbar("Error", "Invalid OTP");
    }

    isLoading.value = false;
  }
}
