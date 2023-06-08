import 'package:flutter/material.dart';
import 'package:sqflite_app/model/person_model.dart';
import 'package:sqflite_app/pages/person_details.dart';
import 'package:sqflite_app/repository/db_helper.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  // * connect with data base helper
  DbHelper helper = DbHelper();
  List<Person>? personList;
  int count = 0;
  Future<void> updateListView() async {
    personList = await helper.getAllPersons();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (personList == null) {
      personList = [];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetails(Person.getNewEmpty());
        },
        child: const Icon(Icons.add),
      ),
      body: getNoteListView(),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: personList!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(personList![index].name),
              subtitle: Text(personList![index].age.toString()),
              trailing: GestureDetector(
                onTap: () {
                  navigateToDetails(personList![index]);
                },
                child: const Icon(Icons.info),
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToDetails(Person person) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PersonDetails(person: person);
        },
      ),
    );
    if (result == true) {
      updateListView();
    }
  }
}

class UpdatePalaceHolder extends StatelessWidget {
  const UpdatePalaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
