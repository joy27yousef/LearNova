import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/onboardingController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/data/source/static.dart';

class Pointcontroller extends StatelessWidget {
  const Pointcontroller({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingcontrollerIMP>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            onboardingList.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 900),
              margin: EdgeInsets.all(2),
              height: 10,
              width: controller.currentPage == index ? 25 : 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.currentPage == index
                    ? const Color.fromARGB(255, 147, 121, 255)
                    : Appcolor.baselight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
