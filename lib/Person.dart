import 'package:hive/hive.dart';

part "Person.g.dart";

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  String? fName;
  @HiveField(1)
  String? lName;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? gender;
  @HiveField(4)
  List<String>? techStack;

  Person(
      {required this.fName,
      required this.lName,
      required this.address,
      required this.gender,
      required this.techStack});

  Person.fromJson(Map<String, dynamic> json) {
    fName = json['fName'];
    lName = json['lName'];
    address = json['address'];
    gender = json['gender'];
    techStack = json['techStack'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['techStack'] = this.techStack;
    return data;
  }

  @override
  String toString() {
    return 'Person{fName: $fName, lName: $lName, address: $address, gender: $gender, techStack: $techStack}';
  }
}
