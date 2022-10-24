import 'package:flutter/material.dart';
import 'package:note_app/widget/author_data_model.dart';
import 'package:note_app/widget/note_card.dart';
import 'package:note_app/screens/create_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<AuthorDataModel> authors = [
    const AuthorDataModel(
      title: 'How to Give a TextField \nColor',
      description:
          'Locate the file where you have placed the TextField widget.\nInside the TextField widget, add the style parameter and assign the TextField widget.\n Inside the TextField widget, add the color parameter and set the color of your choice',
      date: '22-03-21',
    ),
    const AuthorDataModel(
      title: 'How to manage State in \nflutter',
      description:
          'The state in flutter needs to be declared above (in the widget tree),the components that use it. \nThis is so the state can be passed down to child widgets.',
      date: "02-05-21",
    )
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: authors.map(
            (e) {
              return NoteCard(authorData: e);
            },
          ).toList(), //a map that refernces the notecard and authordata to a page
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            tooltip: 'Add Task', //description
            backgroundColor: Colors.blueGrey,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const CreateNotePage()), //on click to another page
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white, //icon color
            ),
          ),
        ),
      ),
    );
  }
}
