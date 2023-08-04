import 'package:flutter/material.dart';

class Item {
  final int id;
  final String name;

  Item(this.id, this.name);
}

List<Item> itemList = [
  Item(1, "Item 1"),
  Item(2, "Item 2"),
  Item(3, "Item 3"),
  // Add more items here
];

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Replace with your desired text direction
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];
          return ItemWidget(
            item: item,
            key: ObjectKey(item.id),
          );
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Item item;

 const ItemWidget({required this.item, required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      // Other widget properties for the item
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Item List'),
        ),
        body: ItemListWidget(),
      ),
    ),
  );
}
