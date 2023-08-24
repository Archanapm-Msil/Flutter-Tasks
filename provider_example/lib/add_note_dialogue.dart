import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({super.key});

  @override
  _AddNoteDialogState createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Note'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: 'Note content'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final content = _controller.text;
            if (content.isNotEmpty) {
              Navigator.pop(context, content);
            }
          },
          child:const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
