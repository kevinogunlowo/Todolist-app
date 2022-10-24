import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:note_app/screens/view_note_page.dart';
import 'package:note_app/widget/note_repository.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatefulWidget {
  final NoteModel note;
  //instance variable assigned to a function
  final Function()? onPressed;
  //constructor of the class
  const NoteCard({Key? key, required this.note, this.onPressed})
      : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    //noteRepository is initialized using provider
    //it rebuilds the screen when changes has been made
    final noteRepository = Provider.of<NoteRepository>(context, listen: false);
    //isFavorited is initialized
    final isFavorited = noteRepository.isFavorited(widget.note);

    return Card(
      //wraps the data in a card
      child: InkWell(
        //gives the card a color upon click
        splashColor: Colors.red,
        // upon click viewNotepage is displayed
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewNotePage(authorData: widget.note),
            ),
          );
        },
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Displays the Title on the card
                      Text(widget.note.title,
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 252, 68, 54),
                            textStyle: const TextStyle(
                              fontSize: 13,
                            ),
                          )),
                      //Space between the title and date
                      const SizedBox(
                        height: 12,
                      ),
                      //dispalys the date on the card
                      //using opacity to make it a bit faint
                      Text(
                        widget.note.date,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //favorite icon
              //upon click it changes to a full icon
              IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border_outlined,
                  size: 20,
                ),
                iconSize: 30,
                color: Colors.redAccent,
                tooltip: 'Favorite',
                onPressed: () {
                  //onpressed makes the icon clickable
                  //it moves the card to the favorite page
                  //once the card is deleted in the favorite page, the fill icon in the homepage disappears
                  widget.onPressed!();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
