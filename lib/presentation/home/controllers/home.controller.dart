import 'package:get/get.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';
import 'package:callmebuddy/infrastructure/navigation/routes.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  Future<void> logout() async {
    try {
      await _authRepository.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar("Error", "Failed to log out");
    }
  }
}
