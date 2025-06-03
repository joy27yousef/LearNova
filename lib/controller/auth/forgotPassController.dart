import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

abstract class Forgotpasscontroller extends GetxController {
  verification();
}

class ForgotpassControllerIMP extends Forgotpasscontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;

  @override
  void onInit() {
    email = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  @override
  verification() {
    if (formstate.currentState!.validate()) {
      print('valid');
      Get.offAllNamed(AppRoutes.resetpassword);
    } else {
      print('not valid');
    }
  }
}
