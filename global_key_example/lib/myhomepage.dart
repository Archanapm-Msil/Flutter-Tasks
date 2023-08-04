import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  // Define the GlobalKey here
  final textFieldKey = GlobalKey<FormFieldState<String>>();
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Key Example'),
      ),
      body: Center(
        child: TextFormField(
          key: textFieldKey, // Assign the global key to the TextField
          decoration: const InputDecoration(labelText: 'Enter text'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Access the TextField using the global key and perform some action
          String? text = textFieldKey.currentState?.value;
          if (text != null) {
            _showSnackBar(context, text);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(text));
  }

  SnackBar _buildSnackBar(String text) {
    return SnackBar(content: Text('Text entered: $text'));
  }
}
