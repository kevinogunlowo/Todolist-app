import 'package:flutter/material.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'Create Notes',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ), //Title of the Screen

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

        actions: [
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.blueGrey,
            ), //Save Icon
            tooltip: 'SAVE',
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 95,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  label: Text('Title'),
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
                maxLines: 8,
                autocorrect: true,
                decoration: const InputDecoration(
                  label: Text('Note'),
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
