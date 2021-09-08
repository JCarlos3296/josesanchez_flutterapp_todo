import 'package:get/get.dart';

class Controller extends GetxController{

  RxBool isLoading = RxBool(false);

  void updateLoading(bool flag) {
    this.isLoading.value = flag;
    update();
  }

}