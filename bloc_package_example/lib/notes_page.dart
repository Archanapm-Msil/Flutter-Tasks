import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notes_bloc.dart';
import 'models/note_model.dart';

class NotesPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Notes App with BLoC'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesInitialState) {
                  return const Center(child: Text('No notes available.'));
                } else if (state is NotesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesLoadedState) {
                  return NotesList(notes: state.notes, notesBloc: notesBloc);
                } else if (state is NotesErrorState) {
                  return Center(child: Text(state.errorMessage));
                }
                return Container();
              },
            ),
          ),
         const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration:const InputDecoration(labelText: 'Enter title'),
                ),
               const SizedBox(height: 10),
                TextFormField(
                  controller: contentController,
                  decoration:const InputDecoration(labelText: 'Enter content'),
                ),
               const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                      final note = NoteModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: titleController.text,
                        content: contentController.text,
                      );
                      notesBloc.add(AddNoteEvent(note: note));
                      titleController.clear();
                      contentController.clear();
                    }
                  },
                  child:const Text('Add Note'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotesList extends StatelessWidget {
  final List<NoteModel> notes;
  final NotesBloc notesBloc;

 const NotesList({required this.notes, required this.notesBloc, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon:const Icon(Icons.edit),
                  onPressed: () {
                    _showEditNoteDialog(context, note);
                  },
                ),
                IconButton(
                  icon:const Icon(Icons.delete),
                  onPressed: () {
                    notesBloc.add(DeleteNoteEvent(id: note.id));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditNoteDialog(BuildContext context, NoteModel note) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildEditNoteDialog(context, note);
      },
    );
  }

  AlertDialog _buildEditNoteDialog(BuildContext context, NoteModel note) {
    final TextEditingController titleController = TextEditingController(text: note.title);
    final TextEditingController contentController = TextEditingController(text: note.content);

    return AlertDialog(
      title:const Text('Edit Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController,
            decoration:const InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: contentController,
            decoration:const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child:const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedNote = NoteModel(
              id: note.id,
              title: titleController.text,
              content: contentController.text,
            );
            notesBloc.add(UpdateNoteEvent(note: updatedNote));
            Navigator.of(context).pop(); // Close the dialog
          },
          child:const Text('Save'),
        ),
      ],
    );
  }
}
