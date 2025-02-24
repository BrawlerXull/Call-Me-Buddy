import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'controllers/otp.controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.lightGreen,
              ),

              const SizedBox(height: 16),

              Text(
                "Enter OTP",
                style: ShadTheme.of(context).textTheme.h1,
              ),

              const SizedBox(height: 8),

              Text(
                "We have sent an OTP to your registered number",
                textAlign: TextAlign.center,
                style: ShadTheme.of(context).textTheme.muted,
              ),

              const SizedBox(height: 24),

              ShadInputOTP(
                onChanged: (v) => print('OTP: $v'),
                maxLength: 6,
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

              const SizedBox(height: 24),

              ShadButton(
                onPressed: () {
                  // controller.verifyOtp();
                },
                child: Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Verify OTP")),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: const Text("Resend OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
