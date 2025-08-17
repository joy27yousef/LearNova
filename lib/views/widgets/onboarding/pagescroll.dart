import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/onboardingController.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/data/source/static.dart';

class Pagescroll extends GetView<OnboardingcontrollerIMP> {
  const Pagescroll({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      flex: 4,
      child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: (val) {
            print(val);
            controller.onChangePage(val);
          },
          itemCount: onboardingList.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  onboardingList[i].title!,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 26, fontWeight: FontWeight.normal),
                ),
                Spacer(),
                Image.asset(
                  onboardingList[i].image!,
                  width: screenWidth * 0.8,
                ),
                Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  onboardingList[i].body!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 18),
                ),
              ],
            );
          }),
    );
  }
}
