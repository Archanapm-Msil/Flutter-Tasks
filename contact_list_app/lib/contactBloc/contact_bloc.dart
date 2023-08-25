import 'package:contact_list_app/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactBloc extends Cubit<List<Contact>> {
  ContactBloc() : super([]);

  void fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse('https://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final contacts = data.map((item) => Contact.fromJson(item)).toList();
        emit(contacts); // Emit the fetched contacts to update the UI
        print(contacts); // Print contacts to console
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (error) {
      print(error); // Print any errors to console
    }
  }
}
