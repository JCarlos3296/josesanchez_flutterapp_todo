import 'package:get/get.dart';
import 'package:josesanchez_flutterapp_todo/src/data/dao_impl/ToDoDaoImpl.dart';
import 'package:josesanchez_flutterapp_todo/src/data/dto/TaskModel.dart';
import 'package:josesanchez_flutterapp_todo/src/utils/Controller.dart';

class ToDoController extends Controller {


  RxList<TaskModel> listTasks = new RxList([]);
  Rx<TaskModel> task = new Rx<TaskModel>(new TaskModel(id: 0, status: 0, name: "", description: ""));
  RxInt incomplete = new RxInt(0);

  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  final ToDoDaoImpl _toDoDaoImpl = new ToDoDaoImpl();

  void getAllTasks() async {
    listTasks.clear();
    incomplete.value = 0;
    listTasks.value = await _toDoDaoImpl.getAllToDo();
    countIncompleteTask();
    update();
  }

  void countIncompleteTask() {
    listTasks.value.forEach((element) {
      if(element.status == 0) {
        incomplete.value += 1;
      }
    });
  }

  void getTask(int id) async {
    task.value = await _toDoDaoImpl.getToDo(id);
    update();
  }

  void insertTask(String task) async {
    TaskModel result = await _toDoDaoImpl.insertToDo(TaskModel(status: 0, name: task, description: ""));
    getAllTasks();
  }

  void editTask(TaskModel t) async {
    int affectedRecord = await _toDoDaoImpl.updateToDo(t);
    getAllTasks();
  }

  void deleteTask(int? id) async {
    int affectedRecord = await _toDoDaoImpl.deleteToDo(id);
    getAllTasks();
  }

  void deleteAllTask() async {
    int affectedRecord = await _toDoDaoImpl.deleteAll();
    getAllTasks();
  }

}