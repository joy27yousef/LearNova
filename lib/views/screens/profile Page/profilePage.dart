import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/profile/EditprofileController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/ConfirmationMessage.dart';
import 'package:learn_nova/views/widgets/profile/listof.dart';

class ProfilePage extends StatelessWidget {
  final userController = Get.find<UserControllerIMP>();
  EditprofileControllerIMP controller = Get.put(EditprofileControllerIMP());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Get.find<UserControllerIMP>().userName.value,
                      style: TextStyle(
                          fontFamily: AppFonts.Poppins,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Get.find<UserControllerIMP>().userEmail.value,
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
                        // Listof(
                        //   title: 'Alarts',
                        //   icon1: Iconsax.alarm,
                        //   icon2: Icons.navigate_next_rounded,
                        //   onTap: () {},
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
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
                            showRegisterConfirmation(context, () {}, 'test',
                                'blabla bak;jBIVUwd ', 'cancel', 'confirm');
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Listof(
                          title: '58'.tr,
                          icon1: Iconsax.command,
                          icon2: Icons.navigate_next_rounded,
                          onTap: () {},
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
                  if (userController.profileImagePath.value.isNotEmpty) {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(
                          File(userController.profileImagePath.value)),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(Appimages.person),
                    );
                  }
                })),
          ],
        ));
  }
}
