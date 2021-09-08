import 'package:flutter/material.dart';
import 'package:josesanchez_flutterapp_todo/src/utils/Responsive.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive res = Responsive.of(context);

    return Container(
      height: res.height,
      width: res.width,
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
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
              Text('Categorias', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: res.dp(4),
              ),),
              SizedBox(
                height: res.hp(2),
              ),
              Card(
                child: ListTile(
                  title: Text('Universidad'),
                  trailing: Icon(Icons.delete, color: Colors.red,),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Trabajo'),
                  trailing: Icon(Icons.delete, color: Colors.red,),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Freelance'),
                  trailing: Icon(Icons.delete, color: Colors.red,),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Casa'),
                  trailing: Icon(Icons.delete, color: Colors.red,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Tú tienes 4 categorias creadas.'),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.indigo, primary: Colors.white),
                    onPressed: () => print('¡Limpiando lista!'),
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
}
