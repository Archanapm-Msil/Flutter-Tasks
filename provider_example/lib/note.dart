import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Note {
  final String id;
  String content;

  Note({
    required this.id,
    required this.content,
  });
}

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(String content) {
    final newNote = Note(id: DateTime.now().toString(), content: content);
    _notes.add(newNote);
    notifyListeners();
  }

  void updateNote(String id, String newContent) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      _notes[noteIndex].content = newContent;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
