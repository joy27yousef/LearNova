import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/services/services.dart';
import 'package:learn_nova/data/source/static.dart';

abstract class Onboardingcontroller extends GetxController {
  next();
  back();
  onChangePage(int x);
  skip();
}

class OnboardingcontrollerIMP extends Onboardingcontroller {
  late PageController pageController;
  MyServices myServices = Get.find();
  int currentPage = 0;
  @override
  back() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  next() {
    currentPage++;
    if (currentPage > onboardingList.length - 1) {
      myServices.sharedPreference.setString('onboarding', '1');
      Get.offAllNamed(AppRoutes.login);
    } else {
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 900), curve: Curves.easeInOut);
    }
  }

  @override
  onChangePage(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  skip() {
    myServices.sharedPreference.setString('onboarding', '1');
    Get.offAllNamed(AppRoutes.login);
  }
}
