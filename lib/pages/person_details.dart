import 'package:flutter/material.dart';
import 'package:sqflite_app/model/person_model.dart';
import 'package:sqflite_app/repository/db_helper.dart';

class PersonDetails extends StatefulWidget {
  final Person person;
  const PersonDetails({super.key, required this.person});

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  // * connect with data base helper
  DbHelper helper = DbHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = widget.person.name;
    ageController.text = widget.person.age.toString();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                  strokeAlign: 2, color: Color.fromARGB(255, 82, 130, 169))),
          shadowColor: Colors.blue,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  icon: Icon(Icons.title),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'age', icon: Icon(Icons.app_registration_sharp)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      Person person = widget.person;
                      person.name = titleController.text;
                      person.age = int.parse(ageController.text);
                      _saveData(person);
                    },
                    child: const Text(
                      'Save',
                      textScaleFactor: 1.2,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      _deleteData(widget.person);
                    },
                    child: const Text(
                      'Delete',
                      textScaleFactor: 1.2,
                    ),
                  )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _saveData(Person person) async {
    if (person.id == 0) {
      await helper.insertNewPerson(person);
    } else {
      await helper.updatePerson(person);
    }
    navigateToLastScreen();
  }

  _deleteData(Person person) async {
    if (person.id > 0) {
      await helper.deletePerson(person);
      navigateToLastScreen();
    }
  }

  void navigateToLastScreen() {
    Navigator.pop(context, true);
  }
}
