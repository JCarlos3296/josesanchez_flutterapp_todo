import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CounterController.dart';
import 'OtherPage.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CounterController counterController = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Clicks: ${counterController.count}")),),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => OtherPage());
          },
          child: Text("Go to other!"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: counterController.increment)
    );
  }
}
