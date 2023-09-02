import 'package:contact_app/model/Watchlist.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define WatchlistEvent classes

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

// Define WatchlistState class

class WatchlistState extends Equatable {
  final List<String> tabs;
  final List<Watchlist> watchlists;

  const WatchlistState(this.tabs, this.watchlists);

  @override
  List<Object> get props => [tabs, watchlists];
}

// Define WatchlistBloc class

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  List<Watchlist> watchlists = [];

  WatchlistBloc() : super(const WatchlistState([], [])) {
    on<AddTabEvent>((event, emit) {
      final List<String> updatedTabs = List.from(state.tabs);
      updatedTabs.add(event.tabName);

      final Watchlist newWatchlist = Watchlist(name: event.tabName, contacts: []);

      final List<Watchlist> updatedWatchlists = List.from(state.watchlists);
      updatedWatchlists.add(newWatchlist);
      emit(WatchlistState(updatedTabs, updatedWatchlists));
    });

    on<AddToWatchlistEvent>((event, emit) {
      final selectedContacts = event.selectedContacts;
      final tabIndex = event.tabIndex;
      if (tabIndex >= 0 && tabIndex < state.tabs.length) {
        final String tabName = state.tabs[tabIndex];
        final Watchlist targetWatchlist = state.watchlists.firstWhere(
          (watchlist) => watchlist.name == tabName,
        );

        targetWatchlist.contacts.addAll(selectedContacts);

        emit(WatchlistState(List.from(state.tabs), List.from(state.watchlists)));
      }
    });

    on<AddContactToTabEvent>((event, emit) {
      final String tabName = event.tabName;
      final Contact contact = event.contact;

      final Watchlist targetWatchlist = state.watchlists.firstWhere(
        (watchlist) => watchlist.name == tabName,
      );

      targetWatchlist.contacts.add(contact);

      emit(WatchlistState(List.from(state.tabs), List.from(state.watchlists)));
    });
  }
}
