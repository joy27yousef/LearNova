import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/auth/signup.dart';
import 'package:path/path.dart';
import '../../core/class/crud.dart';

abstract class SignupController extends GetxController {
  Register(BuildContext context);
}

class SignupControllerIMP extends SignupController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  SignupData signupData = SignupData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  late String userName;
  late String userEmail;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController username;
  late TextEditingController confirmPassword;
  RxBool isChecked = false.obs;



  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    username = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    confirmPassword.dispose();
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Register(context) async {
    if (formstate.currentState!.validate()) {
      print('valid');
      var response = await signupData.getData(
          username.text, email.text, password.text, confirmPassword.text);
      statusrequest = handilingData(response);
      if (Statusrequest.success == statusrequest) {
        var userId = response['user']['id'];
        Get.offAllNamed(AppRoutes.checkEmail, arguments: {'userId': userId});
      } else {
        // alert(context, Appimages.failure, "Your email already exists");

        // statusrequest = Statusrequest.failure;
      }
      update();
    } else {
      print('Not valid');
    }
  }
    bool isShowPassword = true;
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }
   @override
  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
