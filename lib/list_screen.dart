import 'package:flutter/material.dart';
import 'package:flutter_nav_and_db/Person.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'database/LocalDatabase.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Person> list = [];
  LocalDatabase db = LocalDatabase();
  // Future<Box<Person>> box = db.getBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ValueListenableBuilder<Box<Person>>(
            builder: (context, box, _) {
              var list = box.values.toList().cast<Person>();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: box.length,
                itemBuilder: (context, index) {
                  var person = list[index];
                  return DataCard(person);
                },
              );
            },
            valueListenable: Hive.box<Person>(db.DBName).listenable(),
          )),
    );
  }

  Widget DataCard(Person p) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 3,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("Name:"),
              Text("${p.fName} ${p.lName}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("Address:"),
              Text("${p.address}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("Gender:"),
              Text("${p.gender}"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text("Tech Stack:"),
              Text("${p.techStack}"),
            ]),
          ],
        ),
      ),
    );
  }
}
