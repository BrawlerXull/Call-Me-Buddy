import 'package:get/get.dart';

import '../../../../presentation/contact_details/controllers/contact_details.controller.dart';

class ContactDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactDetailsController>(
      () => ContactDetailsController(),
    );
  }
}
