import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/bloc/ContactBloc/contact_bloc.dart';
import 'package:contact_app/bloc/WatchlistBloc/watchlist_bloc.dart';
import 'package:contact_app/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Watchlist App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WatchlistBloc>(create: (_) => WatchlistBloc()),
            BlocProvider<ContactBloc>(create: (_) => ContactBloc(ContactAPI())),

          ],
          child:  const MaterialApp(
            home: WatchlistScreen(selectedContacts: {},),
          ),
        ));
  }
}
