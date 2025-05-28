import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Textinlogsingin extends StatelessWidget {
  final String text1;
  final String text2;
  const Textinlogsingin({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: text1,
          style: TextStyle(
              color: Appcolor.base,
              fontSize: 30,
              fontFamily: AppFonts.Poppins,
              fontWeight: FontWeight.bold)),
      TextSpan(
        text: text2,
        style: TextStyle(
            color: Colors.black54,
            fontSize: 17,
            fontFamily: AppFonts.Poppins,
            fontWeight: FontWeight.w400),
      )
    ]));
  }
}
