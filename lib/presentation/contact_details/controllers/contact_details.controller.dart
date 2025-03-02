import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactDetailsController extends GetxController {
  // Get the contact from the arguments passed
  final Contact contact = Get.arguments as Contact;

  @override
  void onInit() {
    super.onInit();
    
    // Log contact initialization
    print("🔵 [ContactDetailsController] Initialized with contact: ${contact.displayName}");
    
    // Additional log for the contact details
    print("🔵 [ContactDetailsController] Contact details: ${contact.toJson()}");
  }
}
