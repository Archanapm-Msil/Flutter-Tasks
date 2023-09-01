import 'dart:convert';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Watchlist.dart';
import 'package:http/http.dart' as http;

class ContactAPI {
  List<Watchlist> watchlists = [];
  String url = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';

Future<List<Contact>> getUsers() async {
  try {
    final response = await http.get(Uri.parse(url)); 
    if (response.statusCode == 200) {
      final List<Contact> contacts = parseContacts(response.body);
      print('Data fetched successfully: $contacts');
      return contacts;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Error fetching data');
  }
}

List<Contact> parseContacts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
  }

}
