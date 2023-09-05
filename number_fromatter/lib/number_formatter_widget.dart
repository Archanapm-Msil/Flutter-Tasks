import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_fromatter/indian_number_editing_controller.dart';

class NumberFormatterWidget extends StatefulWidget {
  const NumberFormatterWidget({super.key});

  @override
  _NumberFormatterWidgetState createState() => _NumberFormatterWidgetState();
}

class _NumberFormatterWidgetState extends State<NumberFormatterWidget> {
  final controller = IndianNumberEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Amount',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      hintText: '0.00',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      final text = controller.text;
                      controller.value = controller.value.copyWith(
                        selection: TextSelection.fromPosition(
                          TextPosition(offset: text.length),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
