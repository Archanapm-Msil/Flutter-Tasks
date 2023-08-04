import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StaggeredAnimationsApp(),
    );
  }
}

class StaggeredAnimationsApp extends StatefulWidget {
  const StaggeredAnimationsApp({super.key});

  @override
 State<StaggeredAnimationsApp>  createState() {
 return _StaggeredAnimationsAppState();
 }
}

class _StaggeredAnimationsAppState extends State<StaggeredAnimationsApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<bool> _visibleItems;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 800),
    );
    _visibleItems = List.generate(5, (index) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimations() {
    for (int i = 0; i < _visibleItems.length; i++) {
      _controller.reset();
      Future.delayed(Duration(milliseconds: 200 * i), () {
        setState(() {
          _visibleItems[i] = true;
          _controller.forward();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Staggered Animations Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _startAnimations,
              child: const Text('Animate'),
            ),
           const SizedBox(height: 20),
            AnimatedList(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index, animation) {
                return _buildCardItem(index, animation);
              },
              initialItemCount: _visibleItems.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can reset the animations here if needed.
        },
        child:const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildCardItem(int index, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin:const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve:const Interval(
            0.0,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: Card(
          margin:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading:const Icon(Icons.star),
            title: Text('Card ${index + 1}'),
            subtitle: Text('This is card number ${index + 1}'),
          ),
        ),
      ),
    );
  }
}
