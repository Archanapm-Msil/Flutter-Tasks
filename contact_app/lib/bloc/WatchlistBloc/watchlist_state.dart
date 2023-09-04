import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Watchlist.dart';
import 'package:equatable/equatable.dart';

class WatchlistState extends Equatable {
  final List<String> tabs;
  final List<Watchlist> watchlists;
  final List<List<Contact>> users; // List of contacts

  WatchlistState({
    required this.tabs,
    required this.watchlists,
    required this.users,
  });

  @override
  List<Object?> get props => [tabs, watchlists, users];
}

class WatchlistInitial extends WatchlistState {
  WatchlistInitial()
      : super(
          tabs: [],
          watchlists: [],
          users: [],
        );
}

class ContactsLoading extends WatchlistState {
  ContactsLoading()
      : super(
          tabs: [],
          watchlists: [],
          users: [],
        );
}

class ContactsLoaded extends WatchlistState {
  final List<List<Contact>> users;

  ContactsLoaded({
    required this.users,
    required List<String> tabs,
    required List<Watchlist> watchlists,
  }) : super(tabs: tabs, watchlists: watchlists, users: users);
}

class FilteredState extends WatchlistState {
  final List<List<Contact>> filteredUsers;
  final int currentTabIndex;
  final String? selectedSort;

  FilteredState({
    required this.filteredUsers,
    required this.currentTabIndex,
    this.selectedSort,
    required List<String> tabs,
    required List<Watchlist> watchlists,
  }) : super(tabs: tabs, watchlists: watchlists, users: filteredUsers);
}

class ContactsError extends WatchlistState {
  final String errorMessage;

  ContactsError({
    required this.errorMessage,
    required List<String> tabs,
    required List<Watchlist> watchlists,
    required List<List<Contact>> users,
  }) : super(tabs: tabs, watchlists: watchlists, users: users);
}
