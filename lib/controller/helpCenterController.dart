import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterController extends GetxController {
  late TextEditingController first;
  late TextEditingController last;
  late TextEditingController email;
  late TextEditingController number;
  late TextEditingController subject;
  late TextEditingController message;
  @override
  void onInit() {
    first = TextEditingController();
    last = TextEditingController();
    email = TextEditingController();
    number = TextEditingController();
    subject = TextEditingController();
    message = TextEditingController();

    super.onInit();
  }
}
