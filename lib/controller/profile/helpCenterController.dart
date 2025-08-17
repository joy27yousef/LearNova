import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/profile/helpcenter.dart';

class HelpCenterController extends GetxController {
  late TextEditingController first;
  late TextEditingController last;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController subject;
  late TextEditingController message;
  HelpCenterMessage helpCenterMessage =
      HelpCenterMessage(crud: Get.find<Crud>());

  late Statusrequest statusrequest;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  void onInit() {
    first = TextEditingController();
    last = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    subject = TextEditingController();
    message = TextEditingController();

    super.onInit();
  }

  sendMessage(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      print('valid');
      showLoadingDialog("Sending Message..".tr);
      var response = await helpCenterMessage.getData(first.text, last.text,
          email.text, phone.text, subject.text, message.text);
      statusrequest = handilingData(response);
      if (Statusrequest.success == statusrequest) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        showCustomSnackbar(
            title: 'Message Sent',
            message: 'Your message has been successfully sent!',
            icon: Icons.done_rounded,
            backgroundColor: Colors.green);
      } else {
        if (Get.isDialogOpen ?? false) {
          
          Get.back();
        }
        showCustomSnackbar(
            title: 'Error',
            message: 'Failed to send your message. Please try again.',
            icon: Icons.error,
            backgroundColor: Colors.red);
        statusrequest = Statusrequest.failure;
      }
      update();
      first.clear();
      last.clear();
      email.clear();
      phone.clear();
      subject.clear();
      message.clear();
    } else {
      print('Not valid');
    }
  }
}
