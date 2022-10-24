import 'package:flutter/material.dart';
import 'package:note_app/widget/note_card.dart';
import '../widget/author_data_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1; // selected index changes with the bottom navigation
    final size = MediaQuery.of(context).size; //size of the screen
    final List<AuthorDataModel> author = [
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
        date: '02-05-21',
      ),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Color.fromARGB(0, 82, 51, 51), //app bar background color
        centerTitle: false, //centers the title
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: PageView(
        //pageview makes the scren Scrollable
        children: [
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: author
                  .map(
                    (e) => NoteCard(authorData: e),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
