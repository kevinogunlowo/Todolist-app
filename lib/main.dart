import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/note_manager.dart';
import 'package:note_app/screens/home_page.dart';
import 'package:note_app/screens/favorite_page.dart';
import 'package:note_app/widget/note_model.dart';
import 'package:note_app/widget/note_repository.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

//instance variable of NoteRepository
//using late it means the variable will be declared later on
late NoteRepository noteRepository;

//
void main() async {
  //The function initializes hive
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.init(appDocumentDirectory.path);

  //initialize the instance variable noteRepository
  noteRepository = await NoteRepository.init();

  //This is the name of the app and this line of code runs the app
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Nest more than one provider in a list
    return MultiProvider(
      //Listens to a ChangeNotifier
      // expose it to its descendants and rebuilds dependents whenever ChangeNotifier.notifyListeners is called.
      //NoteRepository provider
      providers: [
        Provider<NoteRepository>(
          create: (context) => noteRepository,
        ),

        //NoteManager provider
        ChangeNotifierProvider<NoteManager>(
          create: (context) => NoteManager(noteRepository: noteRepository),
        )
      ],
      //The MaterialApp widget takes a home widget, which defines the layout and theme of the app.

      child: MaterialApp(
        //debug banner at the right hand corner of the screen will disapppear
        debugShowCheckedModeBanner: false,
        //First page Displayed as the HomePage
        home: const MainPage(),
        //Color of the App
        theme: ThemeData(primarySwatch: Colors.red),
      ),
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
  //currnet index of screen
  int _currentIndex = 0;
  //Pages to be dispalyed
  final screens = [
    const HomePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    //This class provides APIs for showing drawers and bottom sheets.
    return Scaffold(
      // _currentIndex keeps track of which tab is currently selected.
      // The underscore in _currentIndex signifies it’s private. The selected index is the state being tracked by _MainPageState.
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      //bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type:
            //its fixed so it wouldnt be animated
            BottomNavigationBarType.fixed,
        //background color of bottom navigation
        backgroundColor: const Color.fromARGB(255, 252, 68, 54),
        //selcted items turn white
        selectedItemColor: Colors.white,
        //unselected items displays this color
        unselectedItemColor: Colors.white70,
        //while unselected it doesnt display the label
        showUnselectedLabels: false,

        currentIndex: _currentIndex,
        onTap: (index) {
          // setstate refreshes the screen
          setState(() {
            _currentIndex = index;
          });
        },

        //These are the defined Icons displayed at the Bottom Navigation
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
