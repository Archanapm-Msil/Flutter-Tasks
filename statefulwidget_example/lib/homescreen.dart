import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the text entered by the user
  String enteredText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: _buildColumn(),
        ),
      ),
    );
  }

  Column _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          onChanged: (value) {
            setState(() {
              enteredText = value;
            });
          },
        ),
      ),
      const SizedBox(height: 30),
      Text(
        enteredText,
        style: const TextStyle(fontSize: 30),
      ),
    ]);
  }
}
