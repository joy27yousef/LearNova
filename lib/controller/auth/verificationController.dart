import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/auth/verification.dart';

abstract class VerificationController extends GetxController {
  chechCode(BuildContext context);
}

class VerificationControllerIMP extends VerificationController {
  VerificationData verify = VerificationData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  late int id;
  late String code;

  @override
  void onInit() {
    id = Get.arguments['userId'];
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  chechCode(context) async {
    showLoadingDialog( 'm9'.tr);
    var response = await verify.getData(id, code);

    response.fold(
      (failure) {
        statusrequest = failure;
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        showCustomSnackbar(
            title: 'a4'.tr,
            message: 'a2'.tr,
            icon: Icons.error_outline_rounded,
            backgroundColor: Colors.red);
      },
      (data) {
        statusrequest = Statusrequest.success;
        if (data['message'] == 'Email verified successfully') {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          print(data);
          showCustomSnackbar(
              title: "m10".tr,
              message: 'm11'.tr,
              icon: Icons.done,
              backgroundColor: Colors.green);

          Get.offAllNamed(AppRoutes.login);
        } else {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          showCustomSnackbar(
              title: 'm6'.tr,
              message: 'a2'.tr,
              icon: Icons.error_outline_rounded,
              backgroundColor: Colors.red);
        }
      },
    );
    update();
  }
}
