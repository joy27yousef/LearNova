import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

Future<bool> alerExitApp() {
  Get.defaultDialog(
    title: '',
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    backgroundColor: Appcolor.backgroundColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          Appimages.exitApp,
          height: 80,
        ),
        SizedBox(height: 50),
        Text(
          'Do you want to exit from LearnNova ??',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: AppFonts.Poppins,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Text(
                'cancel',
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: AppFonts.Poppins,
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                exit(0);
              },
              child: Text(
                'exit',
                style: TextStyle(
                  color: Appcolor.base,
                  fontFamily: AppFonts.Poppins,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return Future.value(true);
}
