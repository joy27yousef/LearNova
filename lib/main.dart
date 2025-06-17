import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/bindings/initialBinding.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/core/constant/themeApp.dart';
import 'package:learn_nova/core/localization/changeLocal.dart';
import 'package:learn_nova/core/localization/translation.dart';
import 'package:learn_nova/core/services/services.dart';
import 'package:learn_nova/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localCtrl = Get.put(localController());
    final themeCtrl = Get.put(ThemeController());

    return Obx(() {
      final isArabic = (localCtrl.language.value.languageCode) == 'ar';
      final isDark = themeCtrl.isDarkMode.value;

      return GetMaterialApp(
        locale: localCtrl.language.value,
        translations: MyTranslation(),
        debugShowCheckedModeBanner: false,
        theme: isArabic ? lightThemeAR : lightThemeEN,
        darkTheme: isArabic ? darkThemeAR : darkThemeEN,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        getPages: routes,
        initialBinding: Initialbinding(),
      );
    });
  }
}
