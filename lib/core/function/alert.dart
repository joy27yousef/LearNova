import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

Future<bool> alert(BuildContext context, String image, String text) async {
  return await showDialog<bool>(
    context: context,
    // barrierDismissible: false,
    builder: (context) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pop(true);
      });

      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titlePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
        title: Image.asset(
          image,
          width: 30,
        ),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
    },
  ).then((value) => value ?? false);
}
