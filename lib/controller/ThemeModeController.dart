import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    isDarkMode.value = _storage.read('isDarkMode') ?? false;

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    super.onInit();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    _storage.write('isDarkMode', isDarkMode.value);
  }
}
