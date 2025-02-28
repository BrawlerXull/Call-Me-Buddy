import 'package:callmebuddy/domain/auth/auth_repository.dart';
import 'package:callmebuddy/infrastructure/dal/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../../presentation/otp/controllers/otp.controller.dart';

class OtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthService());
    Get.lazyPut<OtpController>(
      () => OtpController(),
    );
  }
}
