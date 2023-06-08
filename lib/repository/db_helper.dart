import 'package:sqflite_app/model/person_model.dart';
import 'package:sqflite_app/repository/repository_database.dart';

class DbHelper extends LiteDb {
  //! (1)
  getAllPersons() async {
    List<Person> persons = [];
    String sql = 'SELECT * FROM PERSON';
    List<Map> myMap = await inquiry(sql);
    for (int i = 0; i < myMap.length; i++) {
      persons.add(Person.fromMap(myMap[i]));
    }
    return persons;
  }

  //! (2)
  insertNewPerson(Person person) async {
    String sql = '''
INSERT INTO PERSON(name, age)
VALUES ('${person.name}' , ${person.age})
''';
    int result = await insert(sql);
    return result;
  }

  //! (3)
  updatePerson(Person person) async {
    String sql = '''
UPDATE PERSON SET
name = '${person.name}',
age = '${person.age}'
WHERE
id = ${person.id}
''';
    int result = await update(sql);
    return result;
  }

  //! (4)
  deletePerson(Person person) async {
    String sql = '''
  DELETE FROM PERSON
  WHERE
  id = ${person.id}
''';
    int result = await delete(sql);
    return result;
  }
}
