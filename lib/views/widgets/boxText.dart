import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/onboardingController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Boxtext extends GetView<OnboardingcontrollerIMP> {
  final String textin;
  final int? heightedit;
  final bool withheight;
  final void Function()? onTapFun;

  const Boxtext({
    super.key,
    required this.textin,
    required this.onTapFun,
    this.heightedit,
    this.withheight = false, // قيمة افتراضية
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTapFun,
      child: Container(
        height: withheight ? heightedit?.toDouble() : screenHeight * 0.07,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Appcolor.baselight,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Appcolor.base,
        ),
        child: Center(
          child: Text(
            textin,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.Poppins,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
