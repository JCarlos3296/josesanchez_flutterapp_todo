import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:josesanchez_flutterapp_todo/src/data/dto/TaskModel.dart';
import 'package:josesanchez_flutterapp_todo/src/modules/todo/ToDoController.dart';
import 'package:josesanchez_flutterapp_todo/src/utils/LoadingModal.dart';
import 'package:josesanchez_flutterapp_todo/src/utils/Responsive.dart';

class TodoPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ToDoController todo = Get.put(ToDoController());
    Responsive res = Responsive.of(context);

    return GetBuilder<ToDoController>(
      init: ToDoController(),
      builder: (todo) {
        if(todo.isLoading.value) {
          Future.delayed(Duration(seconds: 5), () {
            todo.updateLoading(false);
          });
          return LoadingModal();
        } else {
          return Container(
            padding: EdgeInsets.only(left: 7.0, right: 7.0, top: 5.0),
            height: res.height,
            width: res.width,
            color: Colors.white,
            child: SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: res.width,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'TODO App',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: res.dp(2),
                            ),
                            children: [
                              TextSpan(
                                  text: '\n by JCarlos Sánchez',
                                  style: TextStyle(color: Colors.black26))
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: res.hp(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tareas', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: res.dp(4),
                        ),),
                        MaterialButton(
                          onPressed: (){
                            showModalInsert(context: context, todo: todo);
                          },
                          color: Colors.orange,
                          child: Icon(Icons.add, color: Colors.white,),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: res.hp(2),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: todo.listTasks.value.length,
                            itemBuilder: (context, i) {
                              TaskModel t = todo.listTasks.value[i];

                              return Card(
                                child: ListTile(
                                  leading: GestureDetector(
                                    child: (t.status == 0 ? Icon(Icons.check_box_outline_blank_outlined) : Icon(Icons.check_box, color: Colors.green,)),
                                    onTap: () {
                                       t.status = (t.status == 0 ? 1 : 0);
                                       todo.editTask(t);
                                    },
                                  ),
                                  title: Text(t.name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red,),
                                        onPressed: () {
                                          todo.updateLoading(true);
                                          todo.deleteTask(t.id);
                                        },),
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),
                                        onPressed: () {
                                          showModalUpdate(context: context, todo: todo, taskModel: t);
                                        },),
                                    ],
                                  )
                                ),
                              );
                            })
                    ),
                    SizedBox(
                      height: res.hp(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tú tienes ${todo.incomplete.value} tarea(s) pendientes.'),
                        TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.indigo, primary: Colors.white),
                          onPressed: () {
                            todo.updateLoading(true);
                            todo.deleteAllTask();
                          },
                          child: Text('Eliminar Todo'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
  void showModalInsert({ required BuildContext context, required ToDoController todo}) {
    TextEditingController txtTaskController = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Ingresa una tarea'),
          content: TextFormField(
            controller: txtTaskController,
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('Cancelar')),
            TextButton(onPressed: () {
              String task = txtTaskController.text;
              if(task.isNotEmpty) {
                todo.updateLoading(true);
                todo.insertTask(task);
              }
              Get.back();
            }, child: Text('Aceptar')),
          ],
        ));
  }

  void showModalUpdate({ required BuildContext context, required ToDoController todo, required TaskModel taskModel}) {
    TextEditingController txtTaskController = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Editar tarea'),
          content: TextFormField(
            controller: txtTaskController,
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('Cancelar')),
            TextButton(onPressed: () {
              String task = txtTaskController.text;
              if(task.isNotEmpty) {
                taskModel.name = task;
                todo.updateLoading(true);
                todo.editTask(taskModel);
              }
              Get.back();
            }, child: Text('Aceptar')),
          ],
        ));
  }
}
