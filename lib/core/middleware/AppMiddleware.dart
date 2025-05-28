import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/services/services.dart';


class Mymiddleware extends GetMiddleware {
  int? get priority => 1;
  MyServices myServices = Get.find();
  @override
  
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreference.getString("onboarding") == '1') {
      return RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
