import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/auth/resetPassword.dart';

abstract class Resetpascontroller extends GetxController {
  savePass();
}

class ResetpascontrollerIMP extends Resetpascontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late int userId;
  late String code;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  Resetpassword resetpassword = Resetpassword(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  bool isShowPassword = true;
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    confirmPassword = TextEditingController();
    userId = Get.arguments['user_id'];
    super.onInit();
  }

  @override
  void dispose() {
    confirmPassword.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  savePass() async {
    showLoadingDialog();
    var response = await resetpassword.getData(
        userId, code, password.text, confirmPassword.text);
    response.fold(
      (failure) {
        statusrequest = failure;
        // alert(context, Appimages.failure, "Error");
      },
      (data) {
        statusrequest = Statusrequest.success;
        if (data['message'] == 'Password reset successfully') {
          print(
              '///////////////////////////////////////////////////////////////');
          update();
          Get.offAllNamed(AppRoutes.login);
          //  alert(
          //     context, Appimages.success, "Email checked\nYour email verified");
        } else {
          // alert(context, Appimages.failure, "Your code is wrong");
        }
      },
    );
    update();
  }
}
