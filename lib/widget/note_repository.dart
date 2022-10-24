import 'package:hive_flutter/adapters.dart';
import 'package:note_app/widget/note_model.dart';

class NoteRepository {
  //created a field to reference our hivedatabase for noteBox and favoriteBox
  //late is used because the values are non-nullable
  late Box noteBox;
  late Box favoriteBox;

  //this function initializes our hivedatabase noteBox and favoriteBox
  //
  Future<bool> _ready() async {
    noteBox = await Hive.openBox('notes');
    favoriteBox = await Hive.openBox('favorites');

    return true;
  }

  //calling ready function  _noteBox can be initialized
  static Future<NoteRepository> init() async {
    final noteRepository = NoteRepository();
    await noteRepository._ready();
    return noteRepository;
  }

  //used to Store the notes created
  //.put takes a dynamic key
  Future<bool> createNote(NoteModel note) async {
    noteBox.put(note.id, note);
    return true;
  }

  //used to delete the notes created  in the noteBox field
  Future<bool> removeNotes(NoteModel note) async {
    noteBox.delete(note.id);
    return true;
  }

  //converts the selected note and displays it as a list on the homepage
  Future<List<NoteModel>> readNotes() async {
    final notes = noteBox.values.toList();
    return notes.map((e) => e as NoteModel).toList();
  }

  //favIds variable stores the ID of the favorited notes
  bool isFavorited(NoteModel note) {
    final favorites = favoriteBox.values.toList();
    final favIds = favorites.map((e) => (e as NoteModel).id).toList();
    return favIds.contains(note.id);
  }

  //used to Store the on tapped notes on the favorite page
  Future<bool> addToFavorite(NoteModel note) async {
    favoriteBox.put(note.id, note);
    return true;
  }

  //used to delete the notes on the favorite page
  Future<bool> deleteAddToFavorite(NoteModel note) async {
    favoriteBox.delete(note.id);
    return true;
  }

  //this closes all instances of the noteBox Boxes
  void close() {
    noteBox.close();
  }

  //this closes all instances of the favoriteBox boxes
  void off() {
    favoriteBox.close();
  }
}
