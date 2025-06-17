import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/auth/signupData.dart';

abstract class SignupController extends GetxController {
  Register();
}

class SignupControllerIMP extends SignupController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late Statusrequest statusrequest;
  SignupData signupData = SignupData(Get.find());
  List data = [];

  RxBool isChecked = false.obs;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController username;
  late TextEditingController confirmPassword;
  bool isShowPassword = true;
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

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
  Register() async {
    if (formstate.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      var response =
          await signupData.postData(username.text, password.text, email.text);

      print(response);
      print("data.length${data.length}");
      statusrequest = handilingData(response);
      if (Statusrequest.success == statusrequest) {
        if (response['status'] == 'success') {
          print('success');

          Get.toNamed(AppRoutes.checkEmail);
        } else {
          statusrequest = Statusrequest.failure;
          return Get.defaultDialog(
              title: 'waring',
              titlePadding: EdgeInsets.zero,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              backgroundColor: Appcolor.backgroundLight,
              content: Text(
                'Your Email is already exists',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppFonts.Poppins,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ));
        }
      }
      update();
    } else {
      print('not valid');
    }
    
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
