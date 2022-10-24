import 'package:flutter/material.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewNotePage extends StatefulWidget {
  //instance of Notemodel which is authordata
  //Declared Variable
  final NoteModel authorData;
  //constructor of noteModel
  const ViewNotePage({Key? key, required this.authorData}) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  @override
  Widget build(BuildContext context) {
    //Visual Scaffold for material design
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 252, 68, 54),
        centerTitle: false,
        title: Text(
          'Note Details',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 2,
              wordSpacing: 1,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), //Return Icon
          tooltip: 'Back',
          //OnPressed The Icon takes You back.
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 252, 68, 54),
                    fontSize: 20,
                  ),
                  widget.authorData.title,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.authorData.description,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 78, 72, 72),
                    fontSize: 13,
                    height: 2,
                    wordSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
