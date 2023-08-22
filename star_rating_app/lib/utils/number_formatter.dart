import 'package:flutter/services.dart';

class NumberRangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    final double number = double.tryParse(newValue.text) ?? 0.0;

    if (number > 5.0) {
      return oldValue;
    }
    return newValue;
  }
}
