import 'package:flutter/cupertino.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:note_app/widget/note_repository.dart';

//NoteManager is a class that extends changenotifier
//NoteManager can as well have fields that we can use to introduce composition inside the class
//NoteManager can have more than one function
class NoteManager extends ChangeNotifier {
  //declared variable
  //it can also be called a NoteManager field or property
  //NoteManager can have more than one field(i.e it can depend on more than one field)
  //NoteManager depends on NoteRepository and this concept is called COMPOSITION
  //NoteRepository must be initailised inside a constructor
  final NoteRepository noteRepository;
//This is a constructor for NoteManager class
//it is used to initialize the field or variable (that is NoteRepository in this context)
//required is used when the constructor has curly braces{}
//'this' is used when the construcor doesnt have curly braces
  NoteManager({
    required this.noteRepository,
  });

  //Function that readnotes
  Future<List<NoteModel>> getNotes() async {
    return noteRepository.readNotes();
  }

  //Function that deletes created cards and it listens to changes and rebuilds it.
  //Future represents the result of async
  //await waits for the Future to complete before executing the subsequence statement
  //notifyListeners listens to changees then rebuilds the screen
  Future<void> removeNotes(NoteModel note) async {
    await noteRepository.removeNotes(note);
    // notifyListeners();
  }

  //Function that selects favorited cards
  //async is declared because it has to wait
  Future<void> isFavorited(NoteModel note) async {
    noteRepository.isFavorited(note);
    // notifyListeners();
  }

  //Function that adds favorite note
  Future<void> addToFavorite(NoteModel note) async {
    await noteRepository.addToFavorite(note);
    // notifyListeners();
  }

  //Function that deletes Added Favorite Note
  Future<void> deleteAddToFavorite(NoteModel note) async {
    await noteRepository.deleteAddToFavorite(note);
    // notifyListeners();
  }
}
