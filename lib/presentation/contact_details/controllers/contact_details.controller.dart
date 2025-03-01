import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactDetailsController extends GetxController {
  //TODO: Implement ContactDetailsController
  final Contact contact = Get.arguments as Contact;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print(contact);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
