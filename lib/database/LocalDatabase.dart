// import 'package:sqflite/sqflite.dart';

import 'package:flutter_nav_and_db/Person.dart';
import 'package:hive/hive.dart';

class LocalDatabase {
  String DBName = "LocalHiveDB";

  Future<Box<Person>> getBox() async {
    return Hive.box<Person>(DBName);
  }

  Future<void> insertHiveDb(Person person) async {
    // var box = await Hive.openBox<Person>(DBName);
    // box.put(DateTime.now().millisecondsSinceEpoch, person);
    Hive.box<Person>(DBName).add(person);
    person.save();
  }

  Future<void> getAllData() async {}

  Future<Person?> getById(String id) async {
    Person? p = Hive.box<Person>(DBName).get(id);
    return p;
  }

  Future<void> deleteById(String id) async {
    Hive.box<Person>(DBName).delete(id);
  }
}
