import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/note_manager.dart';
import 'package:note_app/widget/note_card.dart';
import 'package:note_app/screens/create_note_page.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:note_app/widget/note_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //MediaQuery displays the size of the Screen
    final size = MediaQuery.of(context).size;
    //noteRepository is an instance that read's NoteRepository
    final noteRepository = context.read<NoteRepository>();
    //noteManager is an intance Variable that reads NoteManager
    final noteManager = Provider.of<NoteManager>(context, listen: true);

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
          'Notes',
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
          //valuelistenable listens to changes in noteBox
          valueListenable: noteRepository.noteBox.listenable(),

          //The ValueListenable whose value you depend on in order to build, it requires context,box and child.
          builder: (context, box, child) {
            //displays all open Boxes by using the refernce defined called notes
            final noteBox = Hive.box('notes').values;
            //instance variable being declared called myNotes and it displays a list of favorited notes.
            final myNotes = noteBox.map((e) => e as NoteModel).toList();
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
                      //cards being displayed on the homepage are asigned an id and passed as the paramters of key
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
                          noteManager.removeNotes(noteModel);
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                          );
                        },
                        //once the favorite card is clicked,the addToFavorite function is called
                        //the favorited cards are moved to favorite page
                        child: NoteCard(
                          note: noteModel,
                          onPressed: () {
                            noteManager.addToFavorite(noteModel);
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            } else {
              //An icon is displayed at the background alongside Text if the list is empty
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.note_add_rounded,
                      color: Color.fromARGB(255, 252, 68, 54),
                      size: 40,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'You have not Created any note',
                      style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 252, 68, 54)
                            .withOpacity(0.5),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          height: 2,
                          wordSpacing: 1,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
      //Floating Action Button that consists of a tooltip when held down.
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: 'Add Task',
            backgroundColor: const Color.fromARGB(255, 252, 68, 54),
            //on click to another page
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateNotePage()),
              );
            },
            //Displays an icon with a color
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
