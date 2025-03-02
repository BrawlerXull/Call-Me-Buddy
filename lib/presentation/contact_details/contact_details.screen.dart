import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'controllers/contact_details.controller.dart';

class ContactDetailsScreen extends GetView<ContactDetailsController> {
  const ContactDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('ContactDetailsScreen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Align(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      controller.contact.displayName[0],
                      style: const TextStyle(fontSize: 70),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.contact.displayName,
                  style: theme.textTheme.h4,
                ),
              ],
            ),
          ],
        ));
  }
}
