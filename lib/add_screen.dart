import 'package:flutter/material.dart';
import 'package:flutter_nav_and_db/Person.dart';
import 'package:flutter_nav_and_db/database/LocalDatabase.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  LocalDatabase db = LocalDatabase();

  List genders = ["Male", "Female"];
  List knownTech = ["Android", "Flutter", "Ios"];
  List<bool> isKnownTechChecked = [false, false, false];

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int selectedGender = 0;

  void techStackChecked(int pos) {
    setState(() {
      isKnownTechChecked[pos] = !isKnownTechChecked[pos];
    });
  }

  void setGender(int pos) {
    setState(() {
      selectedGender = pos;
    });
  }

  void addDataToDb() async {
    setState(() {
      List<String> tech = [];
      for (int i = 0; i < isKnownTechChecked.length; i++) {
        if (isKnownTechChecked.elementAt(i)) {
          tech.add(knownTech.elementAt(i));
        }
      }
      Person p = Person(
          fName: fNameController.text,
          lName: lNameController.text,
          address: addressController.text,
          gender: genders.elementAt(selectedGender),
          techStack: tech);

      db.insertHiveDb(p);
      showLoaderDialog(context);

      Future.delayed(const Duration(seconds: 2), () {
        fNameController.clear();
        lNameController.clear();
        addressController.clear();
        FocusScope.of(context).requestFocus(new FocusNode());

        for (int i = 0; i < isKnownTechChecked.length; i++) {
          isKnownTechChecked[i] = false;
        }
        selectedGender = 0;

        Navigator.pop(context);

        ;
        // print("${Hive.box(LocalDatabase().DBName).values.toList()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formTitle("Name"),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "First Name",
                        border: OutlineInputBorder(),
                      ),
                      controller: fNameController,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                        border: OutlineInputBorder(),
                      ),
                      controller: lNameController,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            formTitle("Address"),
            Padding(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  controller: addressController,
                  maxLines: 8, //or null
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      hintText: "Enter your address here"),
                )),
            const SizedBox(
              height: 10,
            ),
            formTitle("Gender"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Male"),
                    Radio(
                      value: 0,
                      groupValue: selectedGender,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setGender(value ?? 0);
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Female"),
                    Radio(
                        value: 1,
                        groupValue: selectedGender,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setGender(value ?? 0);
                        }),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            formTitle("Known tech Stack"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(knownTech.elementAt(0)),
                    Checkbox(
                      value: isKnownTechChecked.elementAt(0),
                      onChanged: (value) {
                        techStackChecked(0);
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(knownTech.elementAt(1)),
                    Checkbox(
                      value: isKnownTechChecked.elementAt(1),
                      onChanged: (value) {
                        techStackChecked(1);
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(knownTech.elementAt(2)),
                    Checkbox(
                      value: isKnownTechChecked.elementAt(2),
                      onChanged: (value) {
                        techStackChecked(2);
                      },
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () => addDataToDb(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Add", style: TextStyle(fontSize: 18)),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget formTitle(String title) {
    return Text(title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.all(7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
