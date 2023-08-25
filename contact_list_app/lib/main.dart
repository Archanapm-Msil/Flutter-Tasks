import 'package:contact_list_app/screens/contact_screen.dart';
import 'package:contact_list_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contact_list_app/contactBloc/contact_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ContactBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: Constants.title,
      home: ContactScreen(),
    );
  }
}
