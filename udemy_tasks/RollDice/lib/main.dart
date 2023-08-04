import 'package:flutter/material.dart';
import 'package:first_app/Gradient_Container.dart';
void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body:  GradientContainer([Colors.redAccent, Colors.white]),
      ),
    ),
  );
}

