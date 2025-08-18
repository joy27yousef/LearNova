import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

Future<bool> alerExitApp(BuildContext context) async {
  Get.defaultDialog(
    title: '',
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Appimages.exitApp,
          height: 80,
        ),
        SizedBox(height: 50),
        Text(
          'Do you want to exit from LearnNova ??',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 30),
        Column(
          children: [
            InkWell(
              onTap: () {
                exit(0); // اغلاق التطبيق
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Appcolor.base,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    'Yes, Exit',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back(); // اغلاق الديالوج فقط
              },
              child: Text(
                'cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Appcolor.base, fontSize: 17),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return Future.value(false); // 👈 امنع الرجوع الفوري
}
