abstract class AuthRepository {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    required Function(String) verificationCompleted,
    required Function(String) verificationFailed,
  });

  Future<void> signInWithCredential(String verificationId, String smsCode);

  Future<void> signOut();
}
