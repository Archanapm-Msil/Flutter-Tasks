import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_rating_app/RatingBloc/star_bloc.dart';
import 'package:star_rating_app/screens/star_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => StarRatingBloc(),
        child: const StarProgressIndicator(),
      ),
    );
  }
}