import 'package:contact_app/bloc/WatchlistBloc/watchlist_event.dart';
import 'package:contact_app/bloc/WatchlistBloc/watchlist_state.dart';
import 'package:contact_app/model/Watchlist.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';



// Define WatchlistBloc class

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  List<Watchlist> watchlists = [];

  WatchlistBloc() : super( WatchlistState( tabs: [], watchlists: [], users: [])) {
    on<AddTabEvent>((event, emit) {
      final List<String> updatedTabs = List.from(state.tabs);
      updatedTabs.add(event.tabName);

      final Watchlist newWatchlist = Watchlist(name: event.tabName, contacts: []);

      final List<Watchlist> updatedWatchlists = List.from(state.watchlists);
      updatedWatchlists.add(newWatchlist);
      emit(WatchlistState(tabs: updatedTabs, watchlists: updatedWatchlists, users: []));
    });

  on<AddToWatchlistEvent>((event, emit) {
  final selectedContacts = event.selectedContacts;
  final tabIndex = event.tabIndex;
  if (tabIndex >= 0 && tabIndex < state.tabs.length) {
    final String tabName = state.tabs[tabIndex];
    final List<Watchlist> updatedWatchlists = List.from(state.watchlists);

    // Find the target watchlist based on tabName
    final Watchlist? targetWatchlist = updatedWatchlists.firstWhereOrNull(
      (watchlist) => watchlist.name == tabName,
    );

    if (targetWatchlist != null) {
      // Add selectedContacts to the target watchlist's contacts list
      targetWatchlist.contacts.addAll(selectedContacts);

      // Update the state with the modified watchlists
      emit(WatchlistState(
        tabs: List.from(state.tabs),
        watchlists: updatedWatchlists,
        users: updatedWatchlists.map((watchlist) => watchlist.contacts).toList(),
      ));
      
    } else {
      // Handle the case when the target watchlist is not found (optional)
      // You can add error handling or other logic here if needed.
      print("Target watchlist not found for tabName: $tabName");
    }
  }
});



    on<AddContactToTabEvent>((event, emit) {
      final String tabName = event.tabName;
      final Contact contact = event.contact;

      final Watchlist targetWatchlist = state.watchlists.firstWhere(
        (watchlist) => watchlist.name == tabName,
      );

      targetWatchlist.contacts.add(contact);

        emit(WatchlistState(tabs: List.from(state.tabs), watchlists: List.from(state.watchlists), users: List.from(state.users)));
    });

  on<OnSortEvent>((event, emit) {
    print("onSort users=====${state.users}");
  // emit(ContactsLoading());
  if (event.selectedSort == 'asc') {
    emit(FilteredState(
      tabs: state.tabs, 
      watchlists: state.watchlists, 
      filteredUsers: event.filteredusers.map((e) {
        if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
          return e
            ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
        }
        return e;
      }).toList(),
      currentTabIndex: event.currentTabIndex,
      selectedSort: event.selectedSort,
    ));
  } else if (event.selectedSort == 'dsc') {
    emit(FilteredState(
      tabs: state.tabs, 
      watchlists: state.watchlists, 
      filteredUsers: event.filteredusers.map((e) {
        if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
          return e
            ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
        }
        return e;
      }).toList(),
      currentTabIndex: event.currentTabIndex,
      selectedSort: event.selectedSort,
    ));
  }
});




  }
}
