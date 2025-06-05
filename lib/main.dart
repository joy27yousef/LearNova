import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:learn_nova/bindings/initialBinding.dart';
import 'package:learn_nova/controller/auth/signupController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/localization/changeLocal.dart';
import 'package:learn_nova/core/localization/translation.dart';
import 'package:learn_nova/core/services/services.dart';
import 'package:learn_nova/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    localController controller = Get.put(localController());

    return GetMaterialApp(
      locale: controller.language,
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Appcolor.backgroundColor),
        primaryColor: Appcolor.base,
      ),
      getPages: routes,
      initialBinding: Initialbinding(),
    );
  }
}
