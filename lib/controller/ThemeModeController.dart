import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  final storage = GetStorage();
  final isDarkMode = false.obs;
  bool followSystem = true;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    var storedTheme = storage.read('isDarkMode');
    if (storedTheme != null) {
      isDarkMode.value = storedTheme;
      followSystem = false;
    } else {
      _updateSystemBrightness();
    }

    _applyTheme();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    followSystem = false; // بعد التغيير اليدوي لن يتبع النظام
    _applyTheme();
    storage.write('isDarkMode', isDarkMode.value);
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

  // هذا يستدعى تلقائياً عند تغيير إعدادات النظام
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (followSystem) {
      _updateSystemBrightness();
      _applyTheme();
    }
  }

  void _updateSystemBrightness() {
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    isDarkMode.value = (brightness == Brightness.dark);
  }
}
