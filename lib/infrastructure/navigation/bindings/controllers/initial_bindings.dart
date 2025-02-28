import 'package:get/get.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';
import 'package:callmebuddy/infrastructure/dal/services/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(AuthService(), permanent: true);
  }
}
