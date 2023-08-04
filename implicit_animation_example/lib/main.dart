import 'package:flutter/material.dart';

void main() {
  runApp(ImplicitAnimationApp());
}

class ImplicitAnimationApp extends StatefulWidget {
  const ImplicitAnimationApp({super.key});

  @override
  State<ImplicitAnimationApp>  createState() {
    return _ImplicitAnimationAppState();
  }
}

class _ImplicitAnimationAppState extends State<ImplicitAnimationApp> {
  double _containerSize = 100.0;
  Color _containerColor = Colors.blue;

  void _increaseSize() {
    setState(() {
      _containerSize = _containerSize == 100.0 ? 200.0 : 100.0;
      _containerColor = _containerColor == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Implicit Animations Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: _containerSize,
                height: _containerSize,
                color: _containerColor,
                curve: Curves.easeInOut,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _increaseSize,
                child: const Text('Increase Size'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
