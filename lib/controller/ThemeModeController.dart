import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    isDarkMode.value = _storage.read('isDarkMode') ?? false;

    _applyTheme();
    super.onInit();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _applyTheme();
    _storage.write('isDarkMode', isDarkMode.value);
  }

  void _applyTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            isDarkMode.value ? Appcolor.backgroundDark : Colors.white,
      ),
    );
  }
}
