import 'package:contact_list_app/contactBloc/contact_bloc.dart';
import 'package:contact_list_app/models/contact.dart';
import 'package:contact_list_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Contact> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.conatctsTitle),
      ),
      body: BlocBuilder<ContactBloc, List<Contact>>(
        builder: (context, contacts) {
          _contacts = contacts; // Store the fetched contacts

          return Column(
            children: [
              const SearchBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                      contact: _contacts[index],
                      onSelected: (isSelected) {
                        setState(() {
                          _contacts[index].isSelected = isSelected;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  final void Function(bool) onSelected;

  ContactCard({required this.contact, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(contact.name ?? ""),
        subtitle: Text(contact.contacts ?? ""),
        trailing: Checkbox(
          value: contact.isSelected,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onSelected(newValue);
            }
          },
        ),
      ),
    );
  }
}










