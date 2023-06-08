import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LiteDb {
  static Database? _db;

  Future<Database?> get getInstance async {
    if (_db == null) {
      _db = await instance();
      return _db;
    } else {
      return _db;
    }
  }

  instance() async {
// Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'lite_sql.db');
// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
CREATE TABLE PERSON (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,age INTEGER)
''');
      print("============= DataBase has been Created ==============");
    });
    print("============= DataBase has been Created ==============");
    return database;
  }

  inquiry(String sqlText) async {
    Database? db = await getInstance;
    //! Get the records
    List<Map> list = await db!.rawQuery(sqlText);
    return list;
  }

  // * SQl CRUD Operation
  insert(String sqlText) async {
    Database? db = await getInstance;
    //! Insert some record
    int count = await db!.rawInsert(sqlText);
    return count;
  }

  update(String sqlText) async {
    Database? db = await getInstance;
    //! Update some record
    int count = await db!.rawUpdate(sqlText);
    return count;
  }

  delete(String sqlText) async {
    Database? db = await getInstance;
    //! Delete some record
    int count = await db!.rawDelete(sqlText);
    return count;
  }
}
