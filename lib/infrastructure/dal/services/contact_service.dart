import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:callmebuddy/domain/contact/contact_repository.dart';

class ContactService implements ContactRepository {
  @override
  Future<List<Contact>> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      return await FlutterContacts.getContacts(withProperties: true);
    } else {
      throw Exception("Permission denied");
    }
  }
}
