import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:volume_controller/volume_controller.dart';

@pragma("vm:entry-point")
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Background message: ${message.notification?.title}");
  await LocalNotificationService().showNotification(message);
  print("playing sound");
  await playSound();
  print("played sound");
}

@pragma("vm:entry-point")
Future<void> playSound() async {
  adjustVolume();
  print("playing sound inner");
  final player = AudioPlayer();
  await player.play(
    AssetSource(
      'notification.mp3',
    ),
    volume: 1,
  );
  print("played sound inner");
}

@pragma("vm:entry-point")
Future<void> adjustVolume() async {
  // VolumeController().showSystemUI = false;
  // double getVolume = await VolumeController().getVolume();
  // VolumeController().setVolume(1);
  // await Future.delayed(const Duration(seconds: 2));
  // VolumeController().setVolume(getVolume);
  final VolumeController volumeController = VolumeController.instance;
  volumeController.showSystemUI = false;
  double getVolume = await volumeController.getVolume();
  volumeController.setVolume(1);
  await Future.delayed(const Duration(seconds: 2));
  volumeController.setVolume(getVolume);
}

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  LocalNotificationService() {
    _initializeLocalNotifications();
  }

  Future<void> _initializeLocalNotifications() async {
    try {
      var androidInitializationSettings =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var darwinInitializationSettings = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) {},
      );
      print("Local notifications initialized");
    } catch (e) {
      print("Error initializing local notifications: $e");
    }
  }

  Future<void> showNotification(RemoteMessage remoteMessage) async {
    try {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString(),
        channelDescription: "Channel Description",
        importance: Importance.high,
        priority: Priority.high,
        // Uncomment the below lines to play notification sound
        sound: const RawResourceAndroidNotificationSound('notification'),
        playSound: true,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
      );

      DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      Future.delayed(Duration.zero, () {
        _flutterLocalNotificationsPlugin.show(
          34,
          remoteMessage.notification!.title.toString(),
          remoteMessage.notification!.body.toString(),
          notificationDetails,
        );
      });
    } catch (e) {
      print("Error showing notification: $e");
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) async {
      print("Foreground message: ${message.notification?.title}");
      showNotification(message);
      await playSound();
    });

    // This handles background messages when the app is in background or terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    // For iOS: Request permission to show notifications
    if (Platform.isIOS) {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // For Android: Request permission for Android 13 and above (POST_NOTIFICATIONS)
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }
  }
}
