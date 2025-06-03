import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/homePageController.dart';
import 'package:learn_nova/data/source/static.dart';

class Pointscrol extends StatelessWidget {
  const Pointscrol({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepagecontrollerIMP>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            onboardingList.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 900),
              margin: EdgeInsets.all(2),
              height: 8,
              width: controller.currentcontent == index ? 20 : 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: controller.currentcontent == index
                      ? Colors.white70
                      : Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
