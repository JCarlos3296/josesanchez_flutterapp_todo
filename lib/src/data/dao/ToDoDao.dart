import 'package:josesanchez_flutterapp_todo/src/data/dto/TaskModel.dart';

abstract class ToDoDao {

  Future<List<TaskModel>> getAllToDo();
  Future<TaskModel> getToDo(int id);
  Future<TaskModel> insertToDo(TaskModel t);
  Future<int> updateToDo(TaskModel t);
  Future<int> deleteToDo(int id);
  Future<int> deleteAll();

}