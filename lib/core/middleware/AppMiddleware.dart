// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learn_nova/core/constant/AppRoutes.dart';
// import 'package:learn_nova/core/services/services.dart';

// class Mymiddleware extends GetMiddleware {
//   int? get priority => 1;
//   MyServices myServices = Get.find();
//   @override

//   RouteSettings? redirect(String? route) {
//     if (myServices.sharedPreference.getString("onboarding") == '1') {
//       return RouteSettings(name: AppRoutes.login);
//     }
//     return null;
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/services/services.dart';

class Mymiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    bool seenOnboarding =
        myServices.sharedPreference.getString("onboarding") == '1';

    final box = GetStorage();
    String? token = box.read('token');

    if (seenOnboarding) {
      if (token != null && token.isNotEmpty) {
        return RouteSettings(name: AppRoutes.mainPage);
      } else {
        return RouteSettings(name: AppRoutes.login);
      }
    }
    return null;
  }
}
