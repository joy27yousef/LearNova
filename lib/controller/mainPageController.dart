
import 'package:get/get.dart';

abstract class Mainpagecontroller extends GetxController {
  changePage(int i);
}

class MainpagecontrollerIMP extends Mainpagecontroller {
  var selectedIndex = 0.obs;

  @override
  void changePage(int index) {
    selectedIndex.value = index;
  }
}
