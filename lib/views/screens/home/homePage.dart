import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/views/widgets/homePage/TestrimonialsHome.dart';
import 'package:learn_nova/views/widgets/homePage/appBarHomePage.dart';
import 'package:learn_nova/views/widgets/homePage/benefitsGen.dart';
import 'package:learn_nova/views/widgets/homePage/categoryWidget.dart';
import 'package:learn_nova/views/widgets/homePage/fAQHomePage.dart';
import 'package:learn_nova/views/widgets/homePage/headerLine.dart';
import 'package:learn_nova/views/widgets/homePage/messageContainer.dart';
import 'package:learn_nova/views/widgets/homePage/trandingCourses.dart';
import 'package:learn_nova/views/widgets/homePage/viewCoursesHomePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomepagecontrollerIMP());

    return WillPopScope(
      onWillPop: () => alerExitApp(context),
      child: GetBuilder<HomepagecontrollerIMP>(builder: (controller) {
        return Handilingdataview(
          statusrequest: controller.statusrequest,
          widget: Scaffold(
            appBar: AppBar(
              toolbarHeight: 10,
            ),
            body: ListView(
              children: [
                Appbarhomepage(),
                Messagecontainer(),
                // category
                Headerline(
                  hint1: '44'.tr,
                  hint2: '45'.tr,
                  onTapHeader: () {
                    Get.toNamed(AppRoutes.categoryPage);
                  },
                ),
                Categorywidget(),
                SizedBox(height: 20),
                //trending Courses
                Headerline(
                  hint1: '46'.tr,
                  hint2: '45'.tr,
                  onTapHeader: () {
                    Get.toNamed(AppRoutes.allTrendingCourse);
                  },
                ),
                SizedBox(
                  height: 270,
                  child: TrandingCourses(
                    num: 3,
                    scrollDirection: Axis.horizontal,
                    imageheight: 100,
                  ),
                ),
                SizedBox(height: 30),
                //New Courses
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text(
                    '47'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                    height: 270,
                    child: Viewcourseshomepage(
                      scrollDirection: Axis.horizontal,
                      num: controller.newCourses.length,
                      courses: controller.newCourses,
                      imageheight: 100,
                    )),
                SizedBox(height: 30),
                //Benefits
                Headerline(
                  hint1: '48'.tr,
                  hint2: '49'.tr,
                  onTapHeader: () {
                    Get.toNamed(AppRoutes.benefits);
                  },
                ),
                // Expanded(
                //   child: Container(
                //       padding: EdgeInsets.all(10),
                //       child: Benefitsgen(
                //         x: 3,
                //         physics: NeverScrollableScrollPhysics(),
                //         y: 8,
                //       )),
                // ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Benefitsgen(
                    x: 3,
                    physics: NeverScrollableScrollPhysics(),
                    y: 8,
                  ),
                ),

                SizedBox(height: 30),
                //free courses
                Headerline(
                  hint1: '50'.tr,
                  hint2: '45'.tr,
                  onTapHeader: () {
                    Get.toNamed(AppRoutes.allFreeCourses);
                  },
                ),
                SizedBox(
                  height: 270,
                  child: Viewcourseshomepage(
                    scrollDirection: Axis.horizontal,
                    imageheight: 100,
                    courses: controller.freeCourses,
                    num: controller.freeCourses.length,
                  ),
                ),
                //Testrimonials
                SizedBox(height: 30),
                Headerline(
                  hint1: '52'.tr,
                  hint2: ''.tr,
                  onTapHeader: () {},
                ),
                Testrimonialshome(),
                SizedBox(height: 15),
                //FAQ
                Headerline(
                  hint1: '86'.tr,
                  hint2: ''.tr,
                  onTapHeader: () {},
                ),
                FAQHomePage(),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}
