import 'package:flutter/material.dart';
import 'package:note_app/screens/home_page.dart';
import 'package:note_app/screens/favorite_page.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; //currnet index of screen
  final screens = [
    //Screens to be dispalyed
    const HomePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ), //the body displays the set index in State
      bottomNavigationBar: BottomNavigationBar(
        //bottom navigation bar
        type:
            BottomNavigationBarType.fixed, //its fixed so it wouldnt be animated
        backgroundColor:
            Colors.blueGrey, //background color of bottom navigation
        selectedItemColor: Colors.white, //selcted items turn white
        unselectedItemColor:
            Colors.white70, //unselected items displays this color
        showUnselectedLabels:
            false, //while unselected it doesnt display the label
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            // setstate refreshes the screen
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
