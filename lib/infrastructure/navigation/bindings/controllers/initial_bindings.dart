import 'package:callmebuddy/domain/contacts/contact_repository.dart';
import 'package:callmebuddy/infrastructure/dal/services/services.dart';
import 'package:get/get.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(AuthService(), permanent: true);
    Get.put<ContactRepository>(ContactService(), permanent: true);
  }
}
