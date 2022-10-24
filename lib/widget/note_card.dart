// ignore_for_file: dead_code

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:note_app/widget/author_data_model.dart';
import 'package:note_app/screens/view_note_page.dart';

class NoteCard extends StatefulWidget {
  final AuthorDataModel authorData;
  const NoteCard({Key? key, required this.authorData})
      : super(key: key); //constructor

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isFavorited =
      false; //changes the default fill of the button on a new page and unclick
  @override
  Widget build(BuildContext context) {
    return Card(
      //wraps the data in a card
      child: InkWell(
        //gives the card a color upon click
        splashColor: Colors.deepOrange,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewNotePage(
                    authorData: widget
                        .authorData), // upon click a new page is displayed
              ));
        },
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            // color: Colors.white30,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.authorData.title),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.authorData.date),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  _isFavorited
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  size: 27.5,
                ),
                iconSize: 30,
                color: Colors.redAccent,
                tooltip: 'Favorite',
                onPressed: () {
                  setState(() {
                    _isFavorited = !_isFavorited;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
