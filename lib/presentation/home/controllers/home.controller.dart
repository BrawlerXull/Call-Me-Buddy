import 'package:callmebuddy/domain/contact/contact_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final ContactRepository _contactsRepository = Get.find<ContactRepository>();

  var contacts = <Contact>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      isLoading.value = true;
      contacts.value = await _contactsRepository.getContacts();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Error", "Failed to log out");
    }
  }
}
