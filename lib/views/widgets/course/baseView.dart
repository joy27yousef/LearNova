import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

import '../../../core/constant/AppColor.dart';

class BaseView extends StatelessWidget {
  BaseView({super.key});
  CourseControllerIMP controller = Get.put(CourseControllerIMP());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () => controller.selectedIndex(0),
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 0
                      ? Appcolor.base
                      : Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      color: controller.selectedIndex.value == 0
                          ? Appcolor.base
                          : Theme.of(context).colorScheme.background,
                      width: 2),
                ),
                child: Center(
                  child: Text('About',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: controller.selectedIndex.value == 0
                                ? Colors.white
                                : const Color.fromARGB(255, 178, 159, 255),
                            fontWeight: controller.selectedIndex.value == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          )),
                ),
              ),
            )),
        Obx(() => InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () => controller.selectedIndex(1),
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == 0
                      ? Theme.of(context).colorScheme.background
                      : Appcolor.base,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                      color: controller.selectedIndex.value == 0
                          ? Theme.of(context).colorScheme.background
                          : Appcolor.base,
                      width: 2),
                ),
                child: Center(
                  child: Center(
                    child: Text('Curriculcum',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: controller.selectedIndex.value == 0
                                  ? const Color.fromARGB(255, 178, 159, 255)
                                  : Colors.white,
                              fontWeight: controller.selectedIndex.value == 0
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            )),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
