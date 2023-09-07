import 'dart:io';

import 'package:flutter/material.dart';
import 'package:number_fromatter/input_done_view.dart';

class IndianNumberInput extends StatefulWidget {
  final TextEditingController controller;

  const IndianNumberInput({super.key, required this.controller});

  @override
  State<IndianNumberInput> createState() => _IndianNumberInputState();
}

class _IndianNumberInputState extends State<IndianNumberInput> {
  FocusNode numberFocusNode = FocusNode();

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
  void initState() {
    numberFocusNode.addListener(() {
      bool hasFocus = numberFocusNode.hasFocus;
      if (hasFocus) {
        if (Platform.isIOS) {
          KeyboardOverlay.showOverlay(context);
        }
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    numberFocusNode.dispose();
    super.dispose();
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
          focusNode: numberFocusNode,
          textAlign: TextAlign.center,
          controller: widget.controller,
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
            widget.controller.value = TextEditingValue(
              text: formattedValue.isNotEmpty ? '₹$formattedValue' : '',
              selection:
                  TextSelection.collapsed(offset: formattedValue.length + 1),
            );
          },
        ),
      ),
    );
  }
}
