import 'package:firebase_auth/firebase_auth.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';

class AuthService implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    required Function(String) verificationCompleted,
    required Function(String) verificationFailed,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential user = await _auth.signInWithCredential(credential);
        verificationCompleted(user.user?.uid ?? ""); 
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationFailed(e.message ?? "Verification failed");
      },
      codeSent: (String verId, int? resendToken) {
        codeSent(verId);
      },
      codeAutoRetrievalTimeout: (String verId) {
        codeAutoRetrievalTimeout(verId);
      },
    );
  }

  @override
  Future<void> signInWithCredential(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);
  }
}
