import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              actions: <Widget>[
                Icon(Icons.person, size: 40,)
              ],
              title: Text("SliverList Example"),
              leading: Icon(Icons.menu),
              backgroundColor: Colors.green,
              expandedHeight: 100.0,
              floating: true,
              pinned: true
            ),
            SliverList(
              delegate: SliverChildListDelegate(_buildList(20)),
            ),// Place sliver widgets here
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildList(int count) {
  List<Widget> listItems = [];
  for (int i = 0; i < count; i++) {
    listItems.add(Padding(padding: const EdgeInsets.all(16.0),
        child: Text(
            'Sliver Item ${i.toString()}',
            style: const TextStyle(fontSize: 22.0)
        )
    ));
  }
  return listItems;
}
