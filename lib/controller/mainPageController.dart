import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class Mainpagecontroller extends GetxController {
  changePage(int i);
}

class MainpagecontrollerIMP extends Mainpagecontroller {
  var selectedIndex = 0.obs;
  String homePage = 'Home Page';
  String profile = 'Profile';
  String search = 'Search';
  String mycourses = 'My Learning';
  @override
  void changePage(int index) {
    selectedIndex.value = index;
  }
}
