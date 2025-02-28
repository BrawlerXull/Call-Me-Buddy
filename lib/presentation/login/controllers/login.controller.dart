import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:callmebuddy/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString verificationId = ''.obs;

  void handleLogin() async {
    print("clicked");
    Get.snackbar("title", "message");
    isLoading.value = true;
    try {
      print("trying..........................");
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAllNamed(Routes.HOME); // Navigate on auto-verification
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "OTP verification failed");
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          print("Verification ID received: $verId");
          Get.toNamed(Routes.OTP);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
      print("tried..........................");
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
    }
    isLoading.value = false;
  }
}
