import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

ThemeData themeEnglish = ThemeData(
    fontFamily: AppFonts.Poppins,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
          color: Appcolor.base,
          fontSize: 30,
          fontFamily: AppFonts.Poppins,
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.black54,
          fontSize: 17,
          fontFamily: AppFonts.Poppins,
          fontWeight: FontWeight.w400),
    ));
