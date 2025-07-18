import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/onboardingController.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:learn_nova/views/widgets/onboarding/onbpardingHeader.dart';
import 'package:learn_nova/views/widgets/onboarding/pagescroll.dart';
import 'package:learn_nova/views/widgets/onboarding/pointcontroller.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingcontrollerIMP());
    return GetBuilder<OnboardingcontrollerIMP>(
        builder: (controller) => Scaffold(
              appBar: AppBar(
                toolbarHeight: -10,
              ),

              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OnbpardingHeader(),
                    Pagescroll(),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Pointcontroller(),
                              Boxtext(
                                textin: (controller.currentPage ==
                                        onboardingList.length - 1)
                                    ? '11'.tr
                                    : '10'.tr,
                                onTapFun: () {
                                  controller.next();
                                },
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ));
  }
}
