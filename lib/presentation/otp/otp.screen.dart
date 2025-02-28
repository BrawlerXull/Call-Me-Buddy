import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'controllers/otp.controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double gap = 30;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.lock_outline,
              size: 80,
              color: ShadTheme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: gap,
            ),
            Text(
              "Enter OTP",
              style: ShadTheme.of(context).textTheme.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: gap,
            ),
            Text(
              "We have sent an OTP to your registered number",
              textAlign: TextAlign.center,
              style: ShadTheme.of(context).textTheme.muted,
            ),
            const SizedBox(
              height: gap,
            ),
            Center(
              child: ShadInputOTP(
                onChanged: (v) {
                  print('OTP entered: $v'); // Debugging
                  controller.otpController.text =
                      v; // ✅ Store OTP in controller
                },
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                children: const [
                  ShadInputOTPGroup(
                    children: [
                      ShadInputOTPSlot(),
                      ShadInputOTPSlot(),
                      ShadInputOTPSlot(),
                      ShadInputOTPSlot(),
                      ShadInputOTPSlot(),
                      ShadInputOTPSlot(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: gap,
            ),
            Obx(() => ShadButton(
                  onPressed: () {
                    controller.verifyOtp();
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Verify OTP"),
                )),
          ],
        ),
      ),
    );
  }
}
