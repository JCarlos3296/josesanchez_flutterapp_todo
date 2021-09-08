import 'package:sqflite/sqflite.dart';

class ToDoDB {
  Database? db;

  final String tableTodo = 'todo';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnStatus = 'status';
  final String columnDescription = 'description';

  ToDoDB._constructor();

  static final ToDoDB _instance = ToDoDB._constructor();

  factory ToDoDB() {
    return _instance;
  }

  Future open() async {
    final String path = await getDatabasesPath();
    final String completePath = path + 'todo.db';

    db = await openDatabase(completePath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''create table $tableTodo (
    $columnId integer primary key autoincrement, 
    $columnName text not null,
    $columnDescription text not null,
    $columnStatus integer not null)''');
    });
  }
}
