import 'package:get/get.dart';

abstract class CategoryController extends GetxController {}

class CategoryControllerIMP extends CategoryController {
  var subcategories = ['Arabic', 'English', 'Germany', 'Franc'].obs;
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
