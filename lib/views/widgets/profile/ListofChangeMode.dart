import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Listofchangemode extends StatelessWidget {
  final String? title;
  final IconData? icon1;
  final IconData? icon2;

  const Listofchangemode({
    super.key,
    required this.title,
    required this.icon1,
    this.icon2,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => ListTile(
          title: Text(
            title!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: Icon(icon1, size: 25),
          trailing: IconButton(
            icon: Icon(themeController.isDarkMode.value
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeController.toggleTheme(),
          ),
        ));
  }
}
