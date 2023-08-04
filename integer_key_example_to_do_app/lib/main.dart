import 'package:flutter/material.dart';

void main() {
  runApp(ToDoListApp());
}

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});
  @override
  State<ToDoListApp> createState() {
    return _ToDoListAppState();
  }
}

class _ToDoListAppState extends State<ToDoListApp> {
  Map<int, String> todoList = {};

  void addItem(int key, String item) {
    setState(() {
      todoList[key] = item;
    });
  }

  void removeItem(int key) {
    setState(() {
      todoList.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    var task = '';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List App'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  int key = todoList.keys.elementAt(index);
                  String? item = todoList[key];
                  return ListTile(
                    title: Text(item!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeItem(key);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (text) {
                        task = text;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Task',
                        hintText: 'Enter your task here',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Generate a random key for simplicity. You can use other methods to ensure unique keys.
                      int key = DateTime.now().millisecondsSinceEpoch;
                      addItem(key,task );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
