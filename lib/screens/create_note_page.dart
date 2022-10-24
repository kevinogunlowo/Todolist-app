import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:note_app/widget/note_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  //Its Used to store the text input
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    final noteRepository = context.read<NoteRepository>();

//creates a visual Scaffold for material Design
    return Scaffold(
      //Defines an AppBar at the top most part of the screen, which includes a Header and BackGroundColor
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 252, 68, 54),
        //centers the title in the appBar
        centerTitle: false,
        //Title of the page which consist of a font,font color,height,fontSize and wordSpacing.
        title: Text(
          'Create Notes',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 2,
              wordSpacing: 1,
            ),
          ),
        ),
        //an iconButton is created
        //OnPressed The Icon takes You back by using pop.
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),

        //an iconButton is created to save the created note
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            tooltip: 'SAVE',
            //onPressed the function saves the card using an ID, upon press it returns us to the homepage and displays the notes there
            onPressed: () {
              //DateTime function is created to display the actual date and time when the note was created
              DateTime dateTime = DateTime.now();
              final today = DateFormat('dd-MM-yyy').format(dateTime);
              noteRepository.createNote(
                NoteModel(
                  //Automatically gives any note we create an ID
                  id: const Uuid().v1(),
                  title: title,
                  description: description,
                  date: today,
                ),
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                onChanged: (value) {
                  print(value);
                  title = value;
                },
                autocorrect: true,
                decoration: const InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 68, 54),
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (value) {
                  description = value;
                },
                maxLines: 8,
                autocorrect: true,
                decoration: const InputDecoration(
                  label: Text(
                    'Note',
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 68, 54),
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
