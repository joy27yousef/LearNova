import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Checkemail extends StatelessWidget {
  const Checkemail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundLight,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(Appimages.checkEmail),
            SizedBox(
              height: 40,
            ),
            Text(
              "35".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                  fontFamily: AppFonts.Poppins,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 40,
            ),
            Boxtext(
                textin: 'check',
                onTapFun: () {
                  Get.offAllNamed(AppRoutes.login);
                })
          ],
        ),
      ),
    );
  }
}
