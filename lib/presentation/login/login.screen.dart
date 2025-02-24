import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double gap = 30;
    final formKey = GlobalKey<ShadFormState>(); 

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ShadForm(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_2,
                size: 80,
                color: ShadTheme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: gap),
              Text(
                "Welcome to Call Me Buddy",
                style: ShadTheme.of(context).textTheme.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: gap),
              Text(
                "Sign Up to Continue",
                style: ShadTheme.of(context).textTheme.small,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: gap),

              ShadInputFormField(
                id: 'fullName',
                label: const Text('Full Name'),
                placeholder: const Text("Enter your full name"),
                controller: controller.nameController,
                leading: Icon(
                  Icons.person,
                  color: ShadTheme.of(context).colorScheme.primary,
                ),
                validator: (v) {
                  if (v.trim().length < 2) {
                    return 'Username must be at least 2 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: gap),

              ShadInputFormField(
                id: 'phoneNumber',
                label: const Text('Phone Number'),
                placeholder: const Text("Enter your phone number"),
                controller: controller.phoneController,
                leading: Icon(
                  Icons.phone,
                  color: ShadTheme.of(context).colorScheme.primary,
                ),
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v.trim().isEmpty) {
                    return 'Phone number is required.';
                  }
                  if (!RegExp(r'^[0-9]{10,}$').hasMatch(v)) {
                    return 'Enter a valid 10-digit phone number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: gap),

              Obx(
                () => ShadButton(
                  onPressed: () {
                    if (formKey.currentState != null &&
                        formKey.currentState!.saveAndValidate()) {
                      controller
                          .handleLogin();
                    } else {
                      print("Form validation failed!");
                    }
                  },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
