import 'package:josesanchez_flutterapp_todo/src/data/ToDoDB.dart';
import 'package:josesanchez_flutterapp_todo/src/data/dao/ToDoDao.dart';
import 'package:josesanchez_flutterapp_todo/src/data/dto/TaskModel.dart';

class ToDoDaoImpl implements ToDoDao {
  late ToDoDB _getInstance;

  ToDoDaoImpl() {
    _getInstance = new ToDoDB();
  }

  @override
  Future<List<TaskModel>> getAllToDo() async {
    await _getInstance.open();
    List<Map> records = await _getInstance.db!.query(
      _getInstance.tableTodo,
      columns: [
        _getInstance.columnId,
        _getInstance.columnName,
        _getInstance.columnDescription,
        _getInstance.columnStatus
      ],
    );

    if (records.length > 0) {
      List<TaskModel> list = [];
      records.forEach((element) {
        list.add(new TaskModel.fromMap(element));
      });
      return list;
    } else {
      return [];
    }
  }

  @override
  Future<TaskModel> getToDo(int id) async {
    await _getInstance.open();

    List<Map> record = await _getInstance.db!.query(_getInstance.tableTodo,
        columns: [
          _getInstance.columnId,
          _getInstance.columnName,
          _getInstance.columnDescription,
          _getInstance.columnStatus
        ],
        where: '${_getInstance.columnId} = ?',
        whereArgs: [id]);

    if (record.length > 0) {
      return new TaskModel.fromMap(record.first);
    } else {
      return new TaskModel(id: 0, status: 0, name: "", description: "");
    }
  }

  @override
  Future<TaskModel> insertToDo(TaskModel t) async {
    await _getInstance.open();
    t.id = await _getInstance.db!.insert(_getInstance.tableTodo, t.toMap());
    return t;
  }

  @override
  Future<int> updateToDo(TaskModel t) async {
    await _getInstance.open();
    return await _getInstance.db!.update(_getInstance.tableTodo, t.toMap(),
        where: '${_getInstance.columnId} = ?', whereArgs: [t.id]);
  }

  @override
  Future<int> deleteToDo(int? id) async {
    await _getInstance.open();
    return await _getInstance.db!.delete(_getInstance.tableTodo, where: '${_getInstance.columnId} = ?', whereArgs: [id]);
  }

  @override
  Future<int> deleteAll() async {
    await _getInstance.open();
    return await _getInstance.db!.delete(_getInstance.tableTodo);
  }
}
