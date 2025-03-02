abstract class FirebaseNotificationRepository {
  Future<void> initialize();
  Future<String> getDeviceToken();
}
