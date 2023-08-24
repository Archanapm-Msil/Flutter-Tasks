import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/add_note_dialogue.dart';
import 'package:provider_example/edit_note_dialog.dart';
import 'note.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Provider Notes App'),
      ),
      body: ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (context, index) {
          final note = noteProvider.notes[index];
          return ListTile(
            title: Text(note.content),
            trailing: IconButton(
              icon:const Icon(Icons.edit),
              onPressed: () async {
                final editedContent = await showDialog(
                  context: context,
                  builder: (context) => EditNoteDialog(initialContent: note.content),
                );

                if (editedContent != null) {
                  noteProvider.updateNote(note.id, editedContent);
                }
              },
            ),
            onLongPress: () {
              noteProvider.deleteNote(note.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newContent = await showDialog(
            context: context,
            builder: (context) => const AddNoteDialog(),
          );

          if (newContent != null) {
            noteProvider.addNote(newContent);
          }
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
