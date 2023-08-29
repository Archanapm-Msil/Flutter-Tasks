


import 'dart:convert';
import 'package:contact_app/model/Contact.dart';
import 'package:http/http.dart';

class ContactAPI {
  String url = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';

  Future<List<Contact>> getUsers() async {
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      print(result);
      return result.map((e) => Contact.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}