import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/contact_details.controller.dart';

class ContactDetailsScreen extends GetView<ContactDetailsController> {
  const ContactDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ContactDetailsScreen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.contact.displayName,
            ),
          ],
        ));
  }
}
