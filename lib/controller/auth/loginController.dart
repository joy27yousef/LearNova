import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

import 'package:learn_nova/core/function/loadindDialog.dart';
import '../../core/function/handilingData.dart';
import '../../data/source/remote/auth/login.dart';

abstract class LoginController extends GetxController {
  login(BuildContext context);
}

class LoginControllerImp extends LoginController {
  late Statusrequest statusrequest;
  LoginData loginData = LoginData(crud: Get.find<Crud>());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  bool isShowPassword = true;
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  login(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      if (formstate.currentState!.validate()) {
        print('valid');
        showLoadingDialog();
        var response = await loginData.getData(email.text, password.text);
        statusrequest = handilingData(response);
        if (Statusrequest.success == statusrequest) {
          String token = response['token'];
          final box = GetStorage();
          await box.write('token', token);
          String? savedToken = box.read('token');
          print("Token from storage: $savedToken");
          var userController = Get.find<UserControllerIMP>();
          userController.userName.value = response['user']['name'];
          userController.userEmail.value = response['user']['email'];
          userController.userId.value = response['user']['id'];
          await userController.setUserData(
            name: response['user']['name'],
            email: response['user']['email'],
            id: response['user']['id'],
          );
          // alert(context, Appimages.success, "The login was done with a whine");
          Get.offAllNamed(AppRoutes.mainPage);
        } else {
          // alert(context, Appimages.failure, "Incorrect email or password");

          statusrequest = Statusrequest.failure;
        }
        update();
      } else {
        print('Not valid');
      }
    }
  }

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
}
