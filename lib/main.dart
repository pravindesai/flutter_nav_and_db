import 'package:flutter/material.dart';
import 'package:flutter_nav_and_db/add_screen.dart';
import 'package:flutter_nav_and_db/list_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Person.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var path = getApplicationDocumentsDirectory();
  // Hive.init(path);

  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>("LocalHiveDB");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screenList = [const AddScreen(), const ListScreen()];

  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(child: screenList.elementAt(selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        selectedFontSize: 18,
        onTap: _onItemTapped,
        currentIndex: selectedIndex,
        backgroundColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(label: "Add", icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: "List", icon: Icon(Icons.list)),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
