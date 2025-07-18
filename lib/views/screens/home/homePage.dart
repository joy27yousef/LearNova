import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/categoryController.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/homePage/TestrimonialsHome.dart';
import 'package:learn_nova/views/widgets/homePage/appBarHomePage.dart';
import 'package:learn_nova/views/widgets/homePage/benefitsGen.dart';
import 'package:learn_nova/views/widgets/homePage/categoryWidget.dart';
import 'package:learn_nova/views/widgets/homePage/fAQHomePage.dart';
import 'package:learn_nova/views/widgets/homePage/headerLine.dart';
import 'package:learn_nova/views/widgets/homePage/messageContainer.dart';
import 'package:learn_nova/views/widgets/homePage/viewCoursesHomePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomepagecontrollerIMP());

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 15,
        ),
        body: ListView(
          children: [
            Appbarhomepage(name: Get.find<UserControllerIMP>().userName.value),
            Messagecontainer(),
            Headerline(
              hint1: '44'.tr,
              hint2: '45'.tr,
              onTapHeader: () {
                Get.toNamed(AppRoutes.categoryPage);
              },
            ),
            GetBuilder<CategoryControllerIMP>(
              builder: (controller) => Handilingdataview(
                statusrequest: controller.statusrequest,
                widget: Categorywidget(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Headerline(
              hint1: '46'.tr,
              hint2: '45'.tr,
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: '47'.tr,
              hint2: '45'.tr,
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: '48'.tr,
              hint2: '49'.tr,
              onTapHeader: () {
                Get.toNamed(AppRoutes.benefits);
              },
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Benefitsgen(
                    x: 3,
                    physics: NeverScrollableScrollPhysics(),
                    y: 8,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: '50'.tr,
              hint2: '45'.tr,
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: '51'.tr,
              hint2: '45'.tr,
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: '52'.tr,
              hint2: ''.tr,
              onTapHeader: () {},
            ),
            Testrimonialshome(),
            SizedBox(
              height: 15,
            ),
            Headerline(
              hint1: '86'.tr,
              hint2: ''.tr,
              onTapHeader: () {},
            ),
            FAQHomePage(),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
