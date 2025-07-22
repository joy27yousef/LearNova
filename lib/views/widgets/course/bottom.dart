import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
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
                  Get.defaultDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: '',
                    content: Column(
                      children: [
                        Image.asset(
                          Appimages.enroll,
                          width: 150,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Text(
                            'Would you really like to enroll in this course ??',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                    actions: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: () async {
                          await controller.enroll();
                          await myCourseController.getMyCourses(
                              Get.find<UserControllerIMP>().userId.value);
                          controller.checkEnrollment();
                          Get.find<MainpagecontrollerIMP>().changePage(1);
                          Get.offAll(() => MainPage());
                          Future.delayed(Duration(milliseconds: 300), () {
                            Get.toNamed(AppRoutes.learningCourse, arguments: {
                              'ID': controller.idCourse,
                            });
                          });
                        },
                        child: Text(
                          'Enroll',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Appcolor.base,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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
