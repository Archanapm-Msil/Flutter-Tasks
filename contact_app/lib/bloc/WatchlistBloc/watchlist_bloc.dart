
import 'package:contact_app/model/contact.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final Contact contact;
  final int tabIndex;

  AddContactToTabEvent(this.contact, this.tabIndex);

  @override
  List<Object> get props => [contact, tabIndex];
}

// State
class WatchlistState extends Equatable {
  final List<String> tabs;

  const WatchlistState(this.tabs);

  @override
  List<Object> get props => [tabs];
}

// Bloc
class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(const WatchlistState([])) {
    on<AddTabEvent>((event, emit) {
      final List<String> updatedTabs = List.from(state.tabs);
      updatedTabs.add(event.tabName);
      emit(WatchlistState(updatedTabs));
    });
  }
}
