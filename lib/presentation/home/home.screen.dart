import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.logout(),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.displayedContacts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: controller.scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: controller.displayedContacts.length +
              (controller.hasMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.displayedContacts.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final contact = controller.displayedContacts[index];
            final String initials = _getInitials(contact.displayName);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  controller.handleContactTap(contact);
                },
                child: ShadCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary,
                            width: 1,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 19,
                          backgroundColor: theme.colorScheme.background,
                          child: Text(
                            initials,
                            style: theme.textTheme.muted.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.displayName,
                              style: theme.textTheme.p,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : "No phone number",
                              style: theme.textTheme.muted,
                            ),
                          ],
                        ),
                      ),
                      ShadButton.outline(
                        size: ShadButtonSize.sm,
                        child: const Icon(LucideIcons.phoneCall, size: 18),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "?";
    List<String> names = name.trim().split(RegExp(r'\s+'));
    return names.length > 1
        ? "${names[0][0]}${names[1][0]}".toUpperCase()
        : names[0][0].toUpperCase();
  }
}
