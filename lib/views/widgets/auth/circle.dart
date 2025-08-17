import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100,
      right: -100,
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: Get.find<ThemeController>().isDarkMode.value
              ? Theme.of(context).colorScheme.background
              : const Color.fromARGB(255, 242, 239, 255),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
