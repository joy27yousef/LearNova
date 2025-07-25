import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

ThemeData lightThemeEN = ThemeData(
  brightness: Brightness.light,
  primaryColor: Appcolor.base,
  scaffoldBackgroundColor: Appcolor.backgroundLight,
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: AppFonts.Poppins,
        fontWeight: FontWeight.bold),
    backgroundColor: Appcolor.backgroundLight,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Poppins,
        color: Colors.grey[500],
        fontSize: 15,
        fontWeight: FontWeight.bold),
    displayLarge: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Poppins,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: AppFonts.Poppins,
        fontSize: 15,
        color: Colors.black45,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.black45,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal),
  ),
  colorScheme: ColorScheme.light(
      primary: Appcolor.base,
      secondary: Colors.black,
      background: Colors.grey.shade100),
);

ThemeData darkThemeEN = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Appcolor.base,
  scaffoldBackgroundColor: Appcolor.backgroundDark,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: AppFonts.Poppins,
        fontWeight: FontWeight.bold),
    backgroundColor: Appcolor.backgroundDark,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Poppins,
        color: Colors.white54,
        fontSize: 15,
        fontWeight: FontWeight.bold),
    displayLarge: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Poppins,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.white38,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: AppFonts.Poppins,
        fontSize: 15,
        color: Colors.white54,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.white60,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        fontFamily: AppFonts.Poppins,
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.normal),
  ),
  colorScheme: ColorScheme.dark(
      primary: Appcolor.base,
      secondary: Colors.white,
      // background: Colors.grey.shade700
      background: Color.fromARGB(255, 65, 57, 86)),
);

//Arabic/////////////////////////////////////////////////////////////////////////////////
ThemeData lightThemeAR = ThemeData(
  brightness: Brightness.light,
  primaryColor: Appcolor.base,
  scaffoldBackgroundColor: Appcolor.backgroundLight,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: AppFonts.Cairo,
        fontWeight: FontWeight.bold),
    backgroundColor: Appcolor.backgroundLight,
    elevation: 0,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Cairo,
        color: Colors.grey[500],
        fontSize: 15,
        fontWeight: FontWeight.bold),
    displayLarge: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Cairo,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: AppFonts.Cairo,
        fontSize: 15,
        color: Colors.black45,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.black45,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.normal),
  ),
  colorScheme: ColorScheme.light(
    primary: Appcolor.base,
    secondary: Colors.black, 
    background: Colors.grey.shade100,
  ),
);

ThemeData darkThemeAR = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Appcolor.base,
  scaffoldBackgroundColor: Appcolor.backgroundDark,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: AppFonts.Cairo,
        fontWeight: FontWeight.bold),
    backgroundColor: Appcolor.backgroundDark,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Cairo,
        color: Colors.white54,
        fontSize: 15,
        fontWeight: FontWeight.bold),
    displayLarge: TextStyle(
        height: 1.5,
        fontFamily: AppFonts.Cairo,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    labelLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.white38,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontFamily: AppFonts.Cairo,
        fontSize: 15,
        color: Colors.white54,
        fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.white60,
        fontSize: 15,
        fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        fontFamily: AppFonts.Cairo,
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.normal),
  ),
  colorScheme: ColorScheme.dark(
      primary: Appcolor.base,
      secondary: Colors.white,
      background: Color.fromARGB(255, 65, 57, 86)),
);
