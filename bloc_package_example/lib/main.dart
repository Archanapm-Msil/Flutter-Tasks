import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_package_example/bloc/notes_bloc.dart';
import 'package:bloc_package_example/notes_repository.dart';
import 'package:bloc_package_example/notes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: BlocProvider(
        create: (context) => NotesBloc(notesRepository: NotesRepository()),
        child: NotesPage(),
      ),
    );
  }
}