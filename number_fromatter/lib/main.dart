import 'package:flutter/material.dart';
import 'package:number_fromatter/number_formatter_widget.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Number Formatter Example'),
        ),
        body: const Center(
          child: NumberFormatterWidget(),
        ),
      ),
    );
  }
}


