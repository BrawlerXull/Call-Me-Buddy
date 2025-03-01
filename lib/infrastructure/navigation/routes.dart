import 'package:flutter/foundation.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Routes {
  static Future<String> getInitialRoute() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (kDebugMode) {
        print("🔹 User is already logged in: ${user.uid}");
      }
      return HOME;
    } else {
      if (kDebugMode) {
        print("🔸 No user logged in. Redirecting to Login...");
      }
      return LOGIN;
    }
  }

  static const HOME = '/home';
  static const LOGIN = '/login';
  static const OTP = '/otp';
  static const CONTACT_DETAILS = '/contact-details';
}
