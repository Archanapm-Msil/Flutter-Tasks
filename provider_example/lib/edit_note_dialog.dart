import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note.dart';

class EditNoteDialog extends StatefulWidget {
  final String initialContent;

  EditNoteDialog({required this.initialContent});

  @override
  _EditNoteDialogState createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Note'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Note content'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newContent = _controller.text;
            if (newContent.isNotEmpty) {
              Navigator.pop(context, newContent);
            }
          },
          child: Text('Save'),
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
