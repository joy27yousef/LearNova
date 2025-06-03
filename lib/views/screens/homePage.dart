import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/homePageController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/views/widgets/homePage/TestrimonialsHome.dart';
import 'package:learn_nova/views/widgets/homePage/appBarHomePage.dart';
import 'package:learn_nova/views/widgets/homePage/benefitsGen.dart';
import 'package:learn_nova/views/widgets/homePage/categoryWidget.dart';
import 'package:learn_nova/views/widgets/homePage/headerLine.dart';
import 'package:learn_nova/views/widgets/homePage/messageContainer.dart';
import 'package:learn_nova/views/widgets/homePage/viewCoursesHomePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomepagecontrollerIMP());
    return Scaffold(
        backgroundColor: Appcolor.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 15,
          backgroundColor: Appcolor.backgroundColor,
        ),
        body: ListView(
          children: [
            Appbarhomepage(name: "joy"),
            Messagecontainer(),
            Headerline(
              hint1: 'Top Category',
              hint2: 'View All',
              onTapHeader: () {
                Get.toNamed(AppRoutes.categoryPage);
              },
            ),
            Categorywidget(),
            SizedBox(
              height: 20,
            ),
            Headerline(
              hint1: 'Popular Courses',
              hint2: 'View All',
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: 'New Courses in\nLearNova',
              hint2: 'View All',
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: 'Why Choose LearNova',
              hint2: 'All Benefits',
              onTapHeader: () {
                Get.toNamed(AppRoutes.benefits);
              },
            ),
            Container(
                padding: EdgeInsets.all(10),
                height: 500,
                child: Benefitsgen(
                  x: 3,
                  physics: NeverScrollableScrollPhysics(),
                  y: 7,
                )),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: 'Get Started with\na Free Courses',
              hint2: 'View All',
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: 'Top Rated Courses',
              hint2: 'View All',
              onTapHeader: () {},
            ),
            Viewcourseshomepage(),
            SizedBox(
              height: 30,
            ),
            Headerline(
              hint1: 'Our Testimonials',
              hint2: 'View All',
              onTapHeader: () {},
            ),
            Testrimonialshome(),
            SizedBox(
              height: 60,
            )
          ],
        ));
  }
}
