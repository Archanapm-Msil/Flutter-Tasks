import 'package:flutter/material.dart';

class IndianNumberEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    String text = this.text;
    text = text.replaceAll(',', '').replaceAll('₹', '');
    text = _formatIndianNumber(text);
    if (text.isNotEmpty && !text.startsWith('₹')) {
      text = '₹ $text';
    }
    return TextSpan(
      text: text,
      style: style,
    );
  }

  String _formatIndianNumber(String value) {
   if (value.isEmpty) {
    return ''; 
  }

  List<String> parts = value.split('.');
  String integerPart = parts[0].replaceAll(',', '');
  String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';

  String lastDigit = integerPart[integerPart.length - 1];
  String result = '';
  int len = integerPart.length - 1;
  int nDigits = 0;

  for (int i = len - 1; i >= 0; i--) {
    result = integerPart[i] + result;
    nDigits++;
    if ((nDigits % 2 == 0) && (i > 0)) {
      result = ',$result';
    }
  }

  return result + lastDigit + decimalPart;
}

}