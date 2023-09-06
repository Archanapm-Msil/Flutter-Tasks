import 'package:flutter/material.dart';
import 'package:number_fromatter/indian_number_editing_controller.dart';

class NumberFormatterWidget extends StatefulWidget {
  const NumberFormatterWidget({Key? key}) : super(key: key);

  @override
  _NumberFormatterWidgetState createState() => _NumberFormatterWidgetState();
}

class _NumberFormatterWidgetState extends State<NumberFormatterWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter Amount',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                IndianNumberInput(controller: controller), // Use IndianNumberInput here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
