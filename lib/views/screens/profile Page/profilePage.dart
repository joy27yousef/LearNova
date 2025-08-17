import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/profile/EditprofileController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/views/widgets/profile/listof.dart';
import 'package:marquee/marquee.dart';

class ProfilePage extends StatelessWidget {
  final userController = Get.find<UserControllerIMP>();
  EditprofileControllerIMP controller = Get.put(EditprofileControllerIMP());
  final bioText = Get.find<UserControllerIMP>().user['bio'] ?? '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => alerExitApp(context),
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text(
                '53'.tr,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              )),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: 90),
                  margin:
                      EdgeInsets.only(top: 40, bottom: 10, left: 25, right: 25),
                  height: 1000,
                  width: 455,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Text(
                        '${Get.find<UserControllerIMP>().user['first_name'] ?? ''} ${Get.find<UserControllerIMP>().user['last_name'] ?? ''}',
                        style: TextStyle(
                            fontFamily: AppFonts.Poppins,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Get.find<UserControllerIMP>().user['email'] ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      bioText.length > 100
                          ? SizedBox(
                              height: 30,
                              child: Marquee(
                                text: bioText,
                                style: Theme.of(context).textTheme.titleMedium,
                                scrollAxis: Axis.horizontal,
                                blankSpace: 50.0,
                                velocity: 40.0,
                                pauseAfterRound: Duration(seconds: 1),
                                startPadding: 10.0,
                                accelerationDuration: Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration:
                                    Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeOut,
                              ),
                            )
                          : Text(
                              Get.find<UserControllerIMP>().user['bio'] ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Listof(
                            title: '54'.tr,
                            icon1: Iconsax.setting_2,
                            icon2: Icons.navigate_next_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.settingsPage);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Listof(
                            title: '55'.tr,
                            icon1: Iconsax.heart_circle,
                            icon2: Icons.navigate_next_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.favoritesPage);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Listof(
                            title: '56'.tr,
                            icon1: Icons.help_outline_rounded,
                            icon2: Icons.navigate_next_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.helpCenterPage);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Listof(
                            title: '57'.tr,
                            icon1: Iconsax.message,
                            icon2: Icons.navigate_next_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.inviteFriendsPage);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Listof(
                            title: '58'.tr,
                            icon1: Iconsax.command,
                            icon2: Icons.navigate_next_rounded,
                            onTap: () {
                              Get.toNamed(AppRoutes.aboutLearnova);
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Obx(() {
                  final user = userController.user;

                  if (user.isEmpty || user['profile_image'] == null) {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(Appimages.person),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(user['profile_image']),
                    );
                  }
                }),
              ),
            ],
          )),
    );
  }
}
