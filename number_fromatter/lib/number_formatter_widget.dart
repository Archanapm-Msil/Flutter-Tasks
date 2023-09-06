import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_fromatter/indian_number_editing_controller.dart';

class NumberFormatterWidget extends StatefulWidget {
  const NumberFormatterWidget({super.key});

  @override
  _NumberFormatterWidgetState createState() => _NumberFormatterWidgetState();
}

class _NumberFormatterWidget extends StatefulWidget {
  const _NumberFormatterWidget({super.key});

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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: controller,
                        keyboardType:const TextInputType.numberWithOptions(decimal: true, ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(
                                r'^-?\d*\.?\d{0,2}$'), 
                          ),
                        ],
                        decoration: const InputDecoration(
                          hintText: '₹ 0',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
