import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.person_2, size: 80, color: Colors.lightGreen),
            const SizedBox(height: 24),
            Text(
              "Welcome to Call Me Buddy",
              style: ShadTheme.of(context).textTheme.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              "Sign Up to Continue",
              style: ShadTheme.of(context).textTheme.small,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ShadInput(
              placeholder: Text("Full Name"),
              leading: const Icon(Icons.person),
            ),
            const SizedBox(height: 24),
            ShadInput(
              placeholder: Text("Phone Number"),
              leading: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            Obx(
              () => ShadButton(
                onPressed: () {},
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
