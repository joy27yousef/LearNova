import 'package:get/get.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/controller/auth/signupController.dart';
import 'package:learn_nova/controller/categoryController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(SignupControllerIMP());
    Get.put(CategoryControllerIMP());
    Get.put(UserControllerIMP());
  }
}
