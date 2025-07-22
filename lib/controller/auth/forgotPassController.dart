import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/auth/resetPassword.dart';

abstract class Forgotpasscontroller extends GetxController {
  sendEmailOTP(BuildContext context);
}

class ForgotpassControllerIMP extends Forgotpasscontroller {
  //init
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  Resetpassword_Email sendEmail = Resetpassword_Email(crud: Get.find<Crud>());
  late TextEditingController email;
  late Statusrequest statusrequest;

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

//function to send Email to the user to verification
  @override
  sendEmailOTP(BuildContext context) async {
    if (!formstate.currentState!.validate()) {
      return;
    }
    statusrequest = Statusrequest.loading;
    showLoadingDialog(context, 'm1'.tr);
    update();
    var result = await sendEmail.getData(email.text);
    result.fold(
      (failure) {
        statusrequest = failure;
        if (Get.isDialogOpen ?? false) Get.back();
        update();
        showCustomSnackbar(
          title: 'a1'.tr,
          message: 'a2',
          icon: Icons.error_rounded,
          backgroundColor: Colors.red,
        );
      },
      (response) {
        statusrequest = Statusrequest.success;
        if (Get.isDialogOpen ?? false) Get.back();
        Get.offAllNamed(AppRoutes.resetpassword,
            arguments: {"user_id": response["user_id"]});
        update();
      },
    );
  }
}
