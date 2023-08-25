import 'package:contact_list_app/models/contact.dart';
import 'package:contact_list_app/screens/create_contact.dart';
import 'package:flutter/material.dart';
import 'package:contact_list_app/utils/constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.conatctsTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(Constants.emptyMessage),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CreateContactGroupBottomSheet(
          onCreateGroup: (String groupName) {
            ContactGroup newGroup =
                ContactGroup(name: groupName, contacts: []);
            // Add the new group to a list of contact groups
            // You might want to call setState() here to update the UI
          },
        );
      },
    );
  },
  child: const Text(Constants.createContactTxt),
            ),
          ],
        ),
      ),
    );
  }
}
