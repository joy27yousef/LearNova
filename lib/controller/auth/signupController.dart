import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/auth/signup.dart';
import '../../core/class/crud.dart';

abstract class SignupController extends GetxController {
  Register(BuildContext context);
}

class SignupControllerIMP extends SignupController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  SignupData signupData = SignupData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController phoneNumber;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  RxBool isChecked = false.obs;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    phoneNumber = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    confirmPassword.dispose();
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Register(context) async {
    if (formstate.currentState!.validate()) {
      showLoadingDialog( 'm7'.tr);
      print('valid');
      var response = await signupData.getData(firstName.text, lastName.text,
          phoneNumber.text, email.text, password.text, confirmPassword.text);
      statusrequest = handilingData(response);
      if (Statusrequest.success == statusrequest) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        var userId = response['user']['id'];
        Get.offAllNamed(AppRoutes.checkEmail, arguments: {'userId': userId});
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        showCustomSnackbar(
            title: 'm8'.tr,
            message: '29'.tr,
            icon: Icons.error_rounded,
            backgroundColor: Colors.red);

        statusrequest = Statusrequest.failure;
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

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
