import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import '../../core/function/handilingData.dart';
import '../../data/source/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login(BuildContext context);
}

class LoginControllerImp extends LoginController {
  //init
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  LoginData loginData = LoginData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  late TextEditingController email;
  late TextEditingController password;
  bool isShowPassword = true;

  @override
  void onInit() {
    FirebaseMessaging.instance.getToken().then((val) {
      print("the token is : $val");
    });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  login(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      print('valid');
      showLoadingDialog( 'm2'.tr);
      var response = await loginData.getData(email.text, password.text);
      statusrequest = handilingData(response);
      if (Statusrequest.success == statusrequest) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        String token = response['token'];
        final box = GetStorage();
        await box.write('token', token);
        String? savedToken = box.read('token');
        print("Token from storage: $savedToken");
        Get.find<UserControllerIMP>().getUserData();
        showCustomSnackbar(
            title: 'm3'.tr,
            message: 'a3'.tr,
            icon: Icons.done_rounded,
            backgroundColor: Colors.green);
        Get.offAllNamed(AppRoutes.mainPage);
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        showCustomSnackbar(
            title: 'm4'.tr,
            message: 'a2'.tr,
            icon: Icons.error,
            backgroundColor: Colors.red);

        statusrequest = Statusrequest.failure;
      }
      update();
    } else {
      print('Not valid');
    }
  }

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }
}
