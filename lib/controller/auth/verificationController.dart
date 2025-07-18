import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
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

  chechCode( context) async {
    var response = await verify.getData(id, code);
    response.fold(
      (failure) {
        statusrequest = failure;
        // alert(context, Appimages.failure, "Error");
      },
      (data)  {
        statusrequest = Statusrequest.success;
        if (data['message'] == 'Email verified successfully') {
          print(data);
          //  alert(
          //     context, Appimages.success, "Email checked\nYour email verified");
          Get.offAllNamed(AppRoutes.login);
        } else {
          // alert(context, Appimages.failure, "Your code is wrong");
        }
      },
    );
    update();
  }
}
