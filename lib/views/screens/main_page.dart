import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/views/screens/MycoursesPage/MyCoursesPage.dart';
import 'package:learn_nova/views/screens/aiAssistantPage.dart';
import 'package:learn_nova/views/screens/home/homePage.dart';
import 'package:learn_nova/views/screens/home/notificationPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/profilePage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatelessWidget {
  MainpagecontrollerIMP controller = Get.find<MainpagecontrollerIMP>();

  MainPage({super.key});

  final pages = [
    HomePage(),
    Mycoursespage(),
    NotificationPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () => alerExitApp(context),
          child: Scaffold(
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
                  Appimages.learning,
                  width: 30,
                ),
                Image.asset(
                  Appimages.notification,
                  width: 25,
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  builder: (context) => const AiAssistantPage(),
                );
              },
              backgroundColor: Appcolor.base,
              shape: const CircleBorder(),
              elevation: 7,
              child: const Icon(
                Icons.chat,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
