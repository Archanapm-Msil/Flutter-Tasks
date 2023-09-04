import 'package:contact_app/model/Contact.dart';

abstract class ContactsEvent {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

// Existing event classes
class FetchContacts extends ContactsEvent {}
// class OnSortEvent extends ContactsEvent {
//   final List<List<Contact>> filteredusers;
//   final int currentTabIndex;
//   final String? selectedSort;

  // const OnSortEvent({
  //   required this.filteredusers,
  //   required this.currentTabIndex,
  //   this.selectedSort,
  // });

  // @override
  // List<Object?> get props => [filteredusers, currentTabIndex, selectedSort];
//}

// Add the ContactAddToWatchlistEvent class
class ContactAddToWatchlistEvent extends ContactsEvent {
  final List<Contact> selectedContacts;
  final int tabIndex;

  ContactAddToWatchlistEvent(this.selectedContacts, this.tabIndex);

  @override
  List<Object?> get props => [selectedContacts, tabIndex];
}
