import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:callmebuddy/infrastructure/navigation/routes.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (kDebugMode) {
        print("✅ User logged out successfully");
      }
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      if (kDebugMode) {
        print("❌ Logout failed: $e");
      }
      Get.snackbar("Error", "Failed to log out");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: "Logout",
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'HomeScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
