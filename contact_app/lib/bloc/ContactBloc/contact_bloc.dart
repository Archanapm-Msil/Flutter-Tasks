
import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/bloc/ContactBloc/contact_event.dart';
import 'package:contact_app/bloc/ContactBloc/contact_state.dart';
import 'package:contact_app/model/Contact.dart';
import 'package:contact_app/model/Watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactBloc extends Bloc<ContactsEvent, ContactState> {
  final ContactAPI _contactApi;
  List<Watchlist> watchlists = [];

  ContactBloc(this._contactApi) : super(ContactsLoading()) {
    print('ContactBloc initialized'); 

    on<FetchContacts>((event, emit) async {
  try {
  print('FetchContacts event triggered');
  final contactList = await _contactApi.getUsers();
  final tabs = _splitItemsIntoTabs(contactList);
  emit(ContactsLoaded(tabs));
} catch (e) {
  emit(ContactsError('Something Went Wrong!'));
}

});


    on<OnSortEvent>((event, emit) {
      // emit(ContactsLoading());
      // if (event.selectedSort == 'asc') {
      //   emit(FilterdState(
      //       filteredusers: event.filteredusers.map((e) {
      //         if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
      //           return e
      //             ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
      //         }
      //         return e;
      //       }).toList(),
      //       currentTabIndex: event.currentTabIndex,
      //       selectedSort: event.selectedSort));
      // } else if (event.selectedSort == 'dsc') {
      //   emit(FilterdState(
      //       filteredusers: event.filteredusers.map((e) {
      //         if (event.currentTabIndex == event.filteredusers.indexOf(e)) {
      //           return e
      //             ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
      //         }
      //         return e;
      //       }).toList(),
      //       currentTabIndex: event.currentTabIndex,
      //       selectedSort: event.selectedSort));
      // }
    });
  
  }

  List<List<Contact>> _splitItemsIntoTabs(List<Contact> items) {
    final tabs = <List<Contact>>[];
    for (int i = 0; i < items.length; i += 20) {
      final endIndex = i + 20;
      final sublist =
          items.sublist(i, endIndex > items.length ? items.length : endIndex);
      tabs.add(sublist);
    }
    return tabs;
  }

}
