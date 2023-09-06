import 'package:flutter/material.dart';

class IndianNumberInput extends StatelessWidget {
  final TextEditingController controller;

  IndianNumberInput({required this.controller});

  String _formatIndianNumber(String value) {
    if (value.isEmpty) {
      return '';
    }

    List<String> parts = value.split('.');
    String integerPart = parts[0].replaceAll(',', '');
    String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
    if (decimalPart.length > 3) {
      decimalPart = decimalPart.substring(0, 3);
    }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            hintText: '₹ 0',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (_) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            String formattedValue = value;
            formattedValue = formattedValue.replaceAll(',', '');
            formattedValue = formattedValue.replaceAll('₹', '');
            if (formattedValue.isNotEmpty) {
              formattedValue = _formatIndianNumber(formattedValue);
            }
            controller.value = TextEditingValue(
              text: formattedValue.isNotEmpty ? '₹$formattedValue' : '',
              selection: TextSelection.collapsed(offset: formattedValue.length + 1),
            );
          },
        ),
      ),
    );
  }
}
