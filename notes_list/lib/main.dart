import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:notes_list/screens/calculator_screen.dart';
import 'package:notes_list/screens/profile.dart';
import 'package:notes_list/screens/user/userdata.dart';
import 'package:notes_list/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:notes_list/model/historyitem.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;
    return ThemeProvider(
      initTheme: user.isdarkmode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: user.isdarkmode ? MyThemes.darkTheme : MyThemes.lightTheme,
          title: 'Flutter Demo',
          home: const MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = const [
    CalculatorApp(),
    CalculatorHistory(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        buttonBackgroundColor: Colors.black26,
        backgroundColor: Colors.transparent,
        height: 55,
        animationDuration: const Duration(milliseconds: 125),
        items: const [
          Icon(Icons.calculate, size: 35, color: Colors.green),
          Icon(Icons.history, size: 35, color: Colors.green),
          Icon(Icons.person_2, size: 30, color: Colors.green),
        ],
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}

class CalculatorHistory extends StatefulWidget {
  const CalculatorHistory({Key? key}) : super(key: key);

  @override
  _CalculatorHistoryState createState() => _CalculatorHistoryState();
}

class _CalculatorHistoryState extends State<CalculatorHistory> {
  late Box<HistoryItem> historyBox;
  List<HistoryItem> historyList = [];
  CollectionReference calc = FirebaseFirestore.instance.collection('history');

  Future<void> addCalc() async {
    try {
      await calc.add({
        'expression': historyList.map((item) => item.toMap()).toList(),
      });
      print('History added');
    } catch (e) {
      print('Failed to add history $e');
    }
  }

  @override
  void initState() {
    super.initState();
    historyBox = Hive.box<HistoryItem>('history');
    historyList = historyBox.values.toList();
    historyBox.listenable().addListener(() {
      setState(() {
        historyList = historyBox.values.toList();
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator History'),
        actions: [
          IconButton(onPressed: (){
          Hive.box<HistoryItem>('history').clear();},
              icon: const Icon(Icons.delete_forever_rounded))
        ],

      ),
      body: ListView.builder(

        itemCount: historyList.length,
        itemBuilder: (BuildContext context, int index) {
          print("hello");
          return Slidable(
            key: const ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children: const [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            child: ListTile(
              selectedTileColor: Colors.black54,
              title: Text('${historyList[index].expression} =',style: TextStyle(fontSize: 20),),
              subtitle: Text(' ${historyList[index].result}',style: TextStyle(fontSize: 16),),
              trailing: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share('${historyList[index].expression} = ${historyList[index].result}');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
