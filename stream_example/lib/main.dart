import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  @override
 State<CounterApp> createState() {
  return _CounterAppState();
 }
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
  StreamController<int> _streamController = StreamController<int>();
  StreamSubscription<int>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = _streamController.stream.listen((event) {
      setState(() {
        _counter = event;
      });
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      _streamController.add(_counter + 1);
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
