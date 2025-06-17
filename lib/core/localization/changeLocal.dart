import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learn_nova/core/constant/AppTheme.dart';
import 'package:learn_nova/core/services/services.dart';

class localController extends GetxController {
  Rx<Locale> language = Locale('en').obs;  

  MyServices myServices = Get.find();

  void changelang(String langcode) {
    Locale locale = Locale(langcode);
    myServices.sharedPreference.setString('lang', langcode);
    language.value = locale; 
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    String? sharedprefLang = myServices.sharedPreference.getString('lang');
    if (sharedprefLang == 'ar') {
      language.value = Locale('ar');
    } else if (sharedprefLang == 'en') {
      language.value = Locale('en');
    } else {
      language.value = Locale(Get.deviceLocale?.languageCode ?? 'en');
    }
  }
}
