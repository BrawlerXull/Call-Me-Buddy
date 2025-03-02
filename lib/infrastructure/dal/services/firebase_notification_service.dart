import 'package:callmebuddy/domain/firebase_notification/firebase_notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';


class FirebaseNotificationService implements FirebaseNotificationRepository {
  late final FirebaseMessaging _messaging;

  FirebaseNotificationService() {
    _messaging = FirebaseMessaging.instance;
  }

  @override
  Future<void> initialize() async {
    try {
      await _messaging.requestPermission(
        alert: true,
        announcement: true,
        criticalAlert: true,
        badge: true,
        sound: true,
        provisional: true,
        carPlay: true,
      );
      if (kDebugMode) {
        print("Permission granted for Firebase Messaging");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error requesting permission for Firebase Messaging: $e");
      }
    }
  }

  @override
  Future<String> getDeviceToken() async {
    try {
      final token = await _messaging.getToken();
      return token!;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting device token: $e");
      }
      rethrow;
    }
  }
}
