import 'package:contact_app/model/Contact.dart';

abstract class ContactState {}

class ContactsInitial extends ContactState {}

class ContactsLoading extends ContactState {
   
}

class ContactsLoaded extends ContactState {
  final List<List<Contact>> users;
  final List<String> tabs; // Define the 'tabs' property here

  ContactsLoaded(this.users, this.tabs);
}

class ContactsError extends ContactState {
  final String errorMessage;

  ContactsError(this.errorMessage);
}
