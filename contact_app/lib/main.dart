import 'package:contact_app/APIServiceManager/contact_api_service.dart';
import 'package:contact_app/ContactBloc/contact_bloc.dart';
import 'package:contact_app/ContactBloc/contact_event.dart';
import 'package:contact_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactAPI(),
      child: BlocProvider(
        create: (context) => ContactBloc(
          RepositoryProvider.of<ContactAPI>(context),
        )..add(FetchContacts()),
        child: MaterialApp(
          title: 'Conatct List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ContactScreen(),
        ),
      ),
    );
  }
}
