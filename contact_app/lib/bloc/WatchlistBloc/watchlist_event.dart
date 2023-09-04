
import 'package:contact_app/model/Contact.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTabEvent extends WatchlistEvent {
  final String tabName;

  AddTabEvent(this.tabName);

  @override
  List<Object> get props => [tabName];
}

class AddContactToTabEvent extends WatchlistEvent {
  final String tabName;
  final Contact contact;

  AddContactToTabEvent(this.tabName, this.contact);

  @override
  List<Object> get props => [tabName, contact];
}

class AddToWatchlistEvent extends WatchlistEvent {
  final List<Contact> selectedContacts;
  final int tabIndex;

  AddToWatchlistEvent(this.selectedContacts, this.tabIndex);

  @override
  List<Object> get props => [selectedContacts, tabIndex];
}

class OnSortEvent extends WatchlistEvent {
  final List<List<Contact>> filteredusers;
  final int currentTabIndex;
  final String selectedSort;

  OnSortEvent({
    required this.filteredusers,
    required this.currentTabIndex,
    required this.selectedSort,
  });

  @override
  List<Object> get props => [filteredusers, currentTabIndex, selectedSort];
}



