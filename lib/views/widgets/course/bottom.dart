import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/views/screens/main_page.dart';

class Bottom extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  final MyCoursesControllerIMP myCourseController = Get.find();

  Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(left: 8, bottom: 10, right: 8),
        child: Obx(() => InkWell(
              onTap: () {
                if (controller.isEnrolled.value) {
                  Get.find<MainpagecontrollerIMP>().changePage(1);
                  Get.offAll(() => MainPage());
                } else {
                  confirmationAelrt(
                    context,
                    Appimages.enroll,
                    'Would you really like to enroll in this course ??',
                    "No, I don't want",
                    'Yes, Enroll',
                    Appcolor.base,
                    () async {
                      await controller.enroll(context);
                      await myCourseController.getMyCourses(
                          Get.find<UserControllerIMP>().user['id']);
                      controller.checkEnrollment();
                      // Get.find<MainpagecontrollerIMP>().changePage(1);
                      // Get.offAll(() => MainPage());
                    },
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Appcolor.base,
                ),
                child: Center(
                  child: Text(
                    controller.isEnrolled.value ? 'Go to course' : 'Enroll Now',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
