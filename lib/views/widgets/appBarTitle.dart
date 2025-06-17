import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Appbartitle extends StatelessWidget {
  final String? title;
  const Appbartitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Appcolor.backgroundLight,
      title: Text(
        title!,
        style: TextStyle(
            fontFamily: AppFonts.Poppins, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
