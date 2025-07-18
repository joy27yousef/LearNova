import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/views/screens/MycoursesPage/MyCoursesPage.dart';
import 'package:learn_nova/views/screens/chatPage.dart';
import 'package:learn_nova/views/screens/home/homePage.dart';
import 'package:learn_nova/views/screens/profile%20Page/profilePage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatelessWidget {
  MainpagecontrollerIMP controller = Get.find<MainpagecontrollerIMP>();

  MainPage({super.key});

  final pages = [
    HomePage(),
    Mycoursespage(),
    Chatpage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            index: controller.selectedIndex.value,
            items: <Image>[
              Image.asset(
                Appimages.home,
                width: 30,
              ),
              Image.asset(
                Appimages.streaming,
                width: 30,
              ),
              Image.asset(
                Appimages.chat,
                width: 30,
              ),
              Image.asset(
                Appimages.myProfile,
                width: 30,
              ),
            ],
            onTap: (index) {
              controller.changePage(index);
            },
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Appcolor.base,
            buttonBackgroundColor: Appcolor.base,
            animationDuration: Duration(milliseconds: 600),
            animationCurve: Curves.decelerate,
          ),
        ));
  }
}
