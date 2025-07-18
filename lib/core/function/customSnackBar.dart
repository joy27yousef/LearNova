import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  IconData? icon,
  Color? backgroundColor,
  Color? textColor,
  SnackPosition position = SnackPosition.BOTTOM,
  Duration duration = const Duration(seconds: 3),
}) {
  Get.snackbar(
    title,
    message,
    icon: icon != null ? Icon(icon, color: textColor ?? Colors.white) : null,
    // snackPosition: position,
    backgroundColor: backgroundColor ?? Colors.blueAccent.withOpacity(0.9),
    colorText: textColor ?? Colors.white,
    borderRadius: 15,
    margin: const EdgeInsets.all(15),
    duration: duration,
  );
}
