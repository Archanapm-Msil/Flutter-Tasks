import 'models/note_model.dart';

class NotesRepository {
  List<NoteModel> _notes = [];

  Future<List<NoteModel>> getNotes() async {
    return _notes;
  }

  Future<void> addNote(NoteModel note) async {
    _notes.add(note);
  }

  Future<void> updateNote(NoteModel note) async {
    final noteIndex = _notes.indexWhere((n) => n.id == note.id);
    if (noteIndex != -1) {
      _notes[noteIndex] = note;
    }
  }

  Future<void> deleteNoteById(int id) async {
    _notes.removeWhere((note) => note.id == id);
  }
}
