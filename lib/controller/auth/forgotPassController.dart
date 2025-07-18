import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/auth/resetPassword.dart';

abstract class Forgotpasscontroller extends GetxController {
  sendEmailOTP();
}

class ForgotpassControllerIMP extends Forgotpasscontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  Resetpassword_Email sendEmail = Resetpassword_Email(crud: Get.find<Crud>());
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

  @override
  sendEmailOTP() async {
    if (!formstate.currentState!.validate()) {
      print('❌ النموذج غير صالح');
      return;
    }
    statusrequest = Statusrequest.loading;
    update();
    var result = await sendEmail.getData(email.text);
    result.fold(
      (failure) {
        statusrequest = failure;
        update();
        Get.snackbar("خطأ", "فشل في الاتصال بالسيرفر أو تحقق الإنترنت");
      },
      (response) {
        statusrequest = Statusrequest.success;
        Get.offAllNamed(AppRoutes.resetpassword,
            arguments: {"user_id": response["user_id"]});
        update();
      },
    );
  }
}
