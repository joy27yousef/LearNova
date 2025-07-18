import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog() {
  Get.dialog(
    Center(child: Center(child: Lottie.asset(Appimages.loading2))),
    barrierDismissible: false,
  );
}
