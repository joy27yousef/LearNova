import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learn_nova/core/constant/AppTheme.dart';
import 'package:learn_nova/core/services/services.dart';

class localController extends GetxController {
  Locale? language;
  ThemeData appTheme = themeEnglish;

  MyServices myServices = Get.find();
  changelang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreference.setString('lang', langcode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    String? sharedprefLang = myServices.sharedPreference.getString('lang');
    if (sharedprefLang == 'ar') {
      language = Locale('ar');
    } else if (sharedprefLang == 'en') {
      language = Locale('en');
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
  }
}
