import 'package:flutter/material.dart';
import 'package:route_example/utils/constants.dart';


class NextScreen extends StatelessWidget {
  const NextScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(Constants.thisNextScreenTx),
            Text(text),
            ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:const Text(Constants.goBackTxt),
        ),
          ],
        ),
      ),
    );
  }
}
