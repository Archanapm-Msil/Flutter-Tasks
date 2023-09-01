

import 'package:contact_app/model/Contact.dart';

class Watchlist {
  final String name;
  final List<Contact> contacts;

  Watchlist({required this.name, this.contacts = const []});
}
