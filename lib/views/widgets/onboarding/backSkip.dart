import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/onboardingController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';


class Backskip extends GetView<OnboardingcontrollerIMP> {
  const Backskip({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.back();
            },
            child: Container(
              height: screenHeight * 0.05, //35
              width: screenWidth * 0.1, //35
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Appcolor.baselight2),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                // color: Colors.white,
                color: Appcolor.base,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.skip();
            },
            child: Text(
              "1".tr,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: screenWidth * 0.06, //23
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.WorkSans,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
