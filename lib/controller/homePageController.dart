import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/services/services.dart';

import 'package:learn_nova/data/source/static.dart';

abstract class Homepagecontroller extends GetxController {
  onChangeMessage(int x);
}

class HomepagecontrollerIMP extends Homepagecontroller {
  //scroll container
  late PageController pageController;
  Timer? timer;
  MyServices myServices = Get.find();
  int currentcontent = 0;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();

    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (pageController.hasClients) {
        currentcontent = (currentcontent + 1) % homeScrol.length;
        pageController.animateToPage(
          currentcontent,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        update();
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    timer?.cancel();
    super.onClose();
  }

  @override
  onChangeMessage(int index) {
    currentcontent = index;
    update();
  }
}
