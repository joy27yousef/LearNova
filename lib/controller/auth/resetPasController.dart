import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

abstract class Resetpascontroller extends GetxController {
  savePass();
}

class ResetpascontrollerIMP extends Resetpascontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController password;
  late TextEditingController confirmPassword;
  bool isShowPassword = true;
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    confirmPassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    confirmPassword.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  savePass() {
    if (formstate.currentState!.validate()) {
      print('valid');
      Get.offAllNamed(AppRoutes.login);
    } else {
      print('not valid');
    }
  }
}
