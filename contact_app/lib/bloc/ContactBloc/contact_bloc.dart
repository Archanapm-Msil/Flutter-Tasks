import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/bloc/ContactBloc/contact_event.dart';
import 'package:contact_app/bloc/ContactBloc/contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactsEvent, ContactState> {
  final ContactAPI _contactApi;
  List<List<Contact>> tabs = [];
  List<String> tabNames = [];
  List<Watchlist> watchlists = [];
  Set<Contact> selectedContacts = Set();


  ContactBloc(this._contactApi) : super(ContactsLoading()) {
    on<FetchContacts>((event, emit) async {
      try {
        final contactList = await _contactApi.getUsers();
        final updatedTabs = _splitItemsIntoTabs(contactList);
        tabs = updatedTabs;
        tabNames = List.generate(updatedTabs.length, (index) => 'Tab ${index + 1}');
        emit(ContactsLoaded(tabs, tabNames));
      } catch (e) {
        emit(ContactsError('Something Went Wrong!'));
      }
    });

    on<ContactAddToWatchlistEvent>((event, emit) {
      final selectedContacts = event.selectedContacts;
      final tabIndex = event.tabIndex;
      if (tabIndex >= 0 && tabIndex < tabs.length) {
        final Watchlist targetWatchlist = watchlists[tabIndex];
        targetWatchlist.contacts.addAll(selectedContacts);
        emit(ContactsLoaded(List.from(tabs), List.from(tabNames)));
      }
    });
  }

  List<List<Contact>> _splitItemsIntoTabs(List<Contact> items) {
    final tabs = <List<Contact>>[];
    for (int i = 0; i < items.length; i += 20) {
      final endIndex = i + 20;
      final sublist =
          items.sublist(i, endIndex > items.length ? items.length : endIndex);
      tabs.add(sublist);
      watchlists.add(Watchlist(name: 'Tab ${tabs.length}', contacts: sublist));
    }
    return tabs;
  }

  void toggleContactSelection(Contact contact) {
    if (selectedContacts.contains(contact)) {
      selectedContacts.remove(contact);
    } else {
      selectedContacts.add(contact);
    }
  }
}


