import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note_app/widget/author_data_model.dart';

class ViewNotePage extends StatefulWidget {
  final AuthorDataModel authorData;
  const ViewNotePage({Key? key, required this.authorData}) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'Note Details',
          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ), //Return Icon
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(
              context,
            ); //OnPressed The Icon takes You back.
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 95,
              ),
              Text(
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                widget.authorData.title,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                style: const TextStyle(fontStyle: FontStyle.italic),
                widget.authorData.date,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                  style: const TextStyle(fontSize: 15),
                  widget.authorData.description),
            ],
          ),
        ),
      ),
    );
  }
}
