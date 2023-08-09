import 'package:flutter/material.dart';

class CustomeRoute extends StatelessWidget {
  const CustomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CutomeRoute'),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Dismiss'))),
    );
  }
}

class MyCustomPageRoute<T> extends MaterialPageRoute<T> {
  MyCustomPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
