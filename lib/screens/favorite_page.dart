import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/widget/note_card.dart';
import 'package:provider/provider.dart';
import '../note_manager.dart';
import '../widget/note_model.dart';
import '../widget/note_repository.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    //MediaQuery displays the size of the Screen
    final size = MediaQuery.of(context).size;
    //noteRepository is initialized
    final noteRepository = context.read<NoteRepository>();
    //noteManager is initialized
    final noteManager = context.read<NoteManager>();

    //creates a visual Scaffold for material Design
    return Scaffold(
      //Defines an AppBar at the top most part of the screen, which includes a Header and BackGroundColor
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        //centers the title in the appBar
        centerTitle: false,
        //Title of the page which consist of a font,font color,height,fontSize and wordSpacing.
        title: Text(
          'Favorites',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 252, 68, 54),
              fontSize: 16,
              height: 2,
              wordSpacing: 1,
            ),
          ),
        ),
      ),
      //THIS IS A WIDGET WHICH INVOKES VALUELISTENABLE WHEN THERE IS A CHANGE IN THE APP
      body: ValueListenableBuilder(

          //THE VALUE IS SUBJECT TO CHANGE FOR IT TO BE ABLE TO REBUILD
          //A METHOD LISTENABLE IS PASSED, TO LISTEN FOR CHANGES.
          valueListenable: noteRepository.favoriteBox.listenable(),

          //The ValueListenable whose value you depend on in order to build, it requires context,box and child as its parameters.
          builder: (context, box, child) {
            //a reference is created
            final favoriteBox = Hive.box('favorites').values;

            //instance variable being declared called myNotes and it displays a list of favorited notes.
            final myNotes = favoriteBox.map((e) => e as NoteModel).toList();

            //A ternary operator that displays a list of favorited notes if myNote is not empty
            if (myNotes.isNotEmpty) {
              //if myNotes is not empty a container is returned.
              return Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.all(12),
                //Listview creates a scrollable linear view
                child: ListView(
                  //the cards are Displayed
                  children: myNotes.map(
                    (noteModel) {
                      //a widget that provides the swipe left delete
                      return Dismissible(
                        key: Key(noteModel.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30.0,
                            )),
                        //a delete function is called from noteManager to remove notes once the swipe left has been performed
                        onDismissed: (direction) {
                          noteManager.deleteAddToFavorite(noteModel);
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                          );
                        },
                        child: NoteCard(note: noteModel),
                      );
                    },
                    //a map that refernces the notecard and authordata to a page
                  ).toList(),
                ),
              );
              //if the list is empty, a background icon and text is being displayed
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.hourglass_empty_outlined,
                      color: Color.fromARGB(255, 252, 68, 54),
                      size: 40,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'No favorite note',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 252, 68, 54)
                            .withOpacity(0.5),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          height: 2,
                          wordSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
