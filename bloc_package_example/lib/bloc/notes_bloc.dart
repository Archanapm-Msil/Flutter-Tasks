import 'package:bloc/bloc.dart';
import 'package:bloc_package_example/notes_repository.dart';
import 'package:bloc_package_example/models/note_model.dart';
abstract class NotesEvent {}

class FetchNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final NoteModel note;

  AddNoteEvent({required this.note});
}

class UpdateNoteEvent extends NotesEvent {
  final NoteModel note;

  UpdateNoteEvent({required this.note});
}

class DeleteNoteEvent extends NotesEvent {
  final int id;

  DeleteNoteEvent({required this.id});
}

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<NoteModel> notes;

  NotesLoadedState({required this.notes});
}

class NotesErrorState extends NotesState {
  final String errorMessage;

  NotesErrorState({required this.errorMessage});
}

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;

  NotesBloc({required this.notesRepository}) : super(NotesInitialState()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoadingState());
      try {
        final List<NoteModel> notes = await notesRepository.getNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState(errorMessage: "Error fetching notes"));
      }
    });

    on<AddNoteEvent>((event, emit) async {
      try {
        await notesRepository.addNote(event.note);
        final List<NoteModel> notes = await notesRepository.getNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState(errorMessage: "Error adding note"));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        await notesRepository.updateNote(event.note);
        final List<NoteModel> notes = await notesRepository.getNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState(errorMessage: "Error updating note"));
      }
    });

    on<DeleteNoteEvent>((event, emit) async {
      try {
        await notesRepository.deleteNoteById(event.id);
        final List<NoteModel> notes = await notesRepository.getNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState(errorMessage: "Error deleting note"));
      }
    });
  }
}
