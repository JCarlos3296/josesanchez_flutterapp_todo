import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CounterController.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CounterController counterController = Get.find();

    return Scaffold(
      body: Center(child: Text("${counterController.count}"),),
    );
  }
}
