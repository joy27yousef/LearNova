import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/auth/resetPassword.dart';

abstract class Resetpascontroller extends GetxController {
  savePass(BuildContext context);
}

class ResetpascontrollerIMP extends Resetpascontroller {
  //init
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Resetpassword resetpassword = Resetpassword(crud: Get.find<Crud>());
  late int userId;
  late String code;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late Statusrequest statusrequest;
  bool isShowPassword = true;

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
  savePass(BuildContext context) async {
    showLoadingDialog(context, 'm5'.tr);
    var response = await resetpassword.getData(
        userId, code, password.text, confirmPassword.text);
    response.fold(
      (failure) {
        statusrequest = failure;
        showCustomSnackbar(
            title: 'a4'.tr,
            message: 'a2'.tr,
            icon: Icons.error,
            backgroundColor: Colors.red);
      },
      (data) {
        statusrequest = Statusrequest.success;
        if (data['message'] == 'Password reset successfully') {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          showCustomSnackbar(
              title: 'Password reset successfully',
              message: 'login!',
              icon: Icons.celebration,
              backgroundColor: Colors.green);

          update();
          Get.offAllNamed(AppRoutes.login);
        } else {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          showCustomSnackbar(
              title: 'm6'.tr,
              message: 'a2'.tr,
              icon: Icons.celebration,
              backgroundColor: Colors.green);
        }
      },
    );
    update();
  }

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }
}
