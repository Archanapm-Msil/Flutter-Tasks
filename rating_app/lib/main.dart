import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_app/blocs/rating_bloc.dart';
import 'package:rating_app/screens/rating_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Lato",
      ),
      home: BlocProvider(
        create: (context) => RatingBloc(),
        child: const RatingPage(),
      ),
    );
  }
}
