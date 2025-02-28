import 'package:callmebuddy/domain/contacts/contact_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';


class ContactService implements ContactRepository {
  @override
  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: true,
        sorted: true,
      );
    } else {
      throw Exception("Permission denied");
    }
  }
}
