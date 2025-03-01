import 'package:callmebuddy/infrastructure/navigation/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:callmebuddy/domain/contacts/contact_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:callmebuddy/domain/auth/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final ContactRepository _contactsRepository = Get.find<ContactRepository>();

  final ScrollController scrollController = ScrollController();

  var allContacts = <Contact>[];
  var displayedContacts = <Contact>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  final int _batchSize = 50;
  int _currentBatchIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _setupScrollListener();
    fetchContacts();
  }

  void handleContactTap(Contact contact) {
    print(contact.toJson());
    Get.toNamed(Routes.CONTACT_DETAILS, arguments: contact);
    Get.snackbar("Contact", "Name: ${contact.displayName}");
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        fetchContacts();
      }
    });
  }

  Future<void> fetchContacts() async {
    if (!hasMore.value || isLoading.value) return;

    isLoading.value = true;
    if (kDebugMode) {
      print("🔵 [HomeController] Fetching contacts... Batch size: $_batchSize");
    }

    try {
      if (allContacts.isEmpty) {
        if (kDebugMode) {
          print("🟡 [HomeController] Fetching all contacts from repository...");
        }
        allContacts = await _contactsRepository.getContacts();
        if (kDebugMode) {
          print(
              "✅ [HomeController] Total contacts fetched: ${allContacts.length}");
        }
      }

      int nextBatchEnd = _currentBatchIndex + _batchSize;
      if (nextBatchEnd > allContacts.length) {
        nextBatchEnd = allContacts.length;
        hasMore.value = false;
      }

      displayedContacts
          .addAll(allContacts.sublist(_currentBatchIndex, nextBatchEnd));

      if (kDebugMode) {
        print(
            "🟢 [HomeController] Loaded batch: $_currentBatchIndex - $nextBatchEnd");
      }

      _currentBatchIndex = nextBatchEnd;
    } catch (e) {
      if (kDebugMode) {
        print("❌ [HomeController] Error fetching contacts: $e");
      }
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
      if (kDebugMode) {
        print("⚪ [HomeController] Contact fetching process completed.");
      }
    }
  }

  Future<void> logout() async {
    if (kDebugMode) {
      print("🔵 [HomeController] Logging out...");
    }

    try {
      await _authRepository.signOut();
      Get.offAllNamed('/login');
      if (kDebugMode) {
        print("✅ [HomeController] Logout successful.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ [HomeController] Logout failed: $e");
      }
      Get.snackbar("Error", "Failed to log out");
    }
  }
}
