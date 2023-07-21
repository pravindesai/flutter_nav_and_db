import 'package:flutter/material.dart';
import 'package:flutter_nav_and_db/Person.dart';
import 'package:flutter_nav_and_db/details_screen.dart';
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

  void navigationToDetails(Person person) {
    print("TAP ${person}");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DetailsScreen()),
    );
  }

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
                  return DataCard(person, navigationToDetails);
                },
              );
            },
            valueListenable: Hive.box<Person>(db.DBName).listenable(),
          )),
    );
  }

  Widget DataCard(Person p, Function onClick) {
    return InkWell(
      onTap: () {
        onClick(p);
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 3,
        shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.blueGrey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text("Name:"),
                Text("${p.fName} ${p.lName}"),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text("Address:"),
                Text("${p.address}"),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text("Gender:"),
                Text("${p.gender}"),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text("Tech Stack:"),
                Text("${p.techStack}"),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
