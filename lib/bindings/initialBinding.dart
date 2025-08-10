import 'package:get/get.dart';

import 'package:learn_nova/controller/auth/signupController.dart';
import 'package:learn_nova/controller/home/SearchController.dart';
import 'package:learn_nova/controller/home/categoryController.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/controller/profile/favoritesCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(UserControllerIMP());
    Get.put(MainpagecontrollerIMP());
    Get.put(SignupControllerIMP());
    Get.put(HomepagecontrollerIMP());
    Get.put(FavoritesCoursesController());
    // Get.put(SearchCourseController());
  }
}
