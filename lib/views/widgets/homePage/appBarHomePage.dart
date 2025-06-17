import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/getGreeting.dart';

class Appbarhomepage extends StatelessWidget {
  final userController = Get.find<UserControllerIMP>();
  final String name;
  Appbarhomepage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsetsDirectional.only(start: 20, top: 8),
                child: Obx(() {
                  if (userController.profileImagePath.value.isNotEmpty) {
                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: FileImage(
                          File(userController.profileImagePath.value)),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Appimages.person),
                    );
                  }
                })),
            SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: getGreeting(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(end: 30),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Get.toNamed(AppRoutes.notificationPage);
                },
                child: Image.asset(
                  Appimages.notification,
                  width: 30,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Get.toNamed(AppRoutes.searhPage);
                },
                child: Image.asset(
                  Appimages.search,
                  width: 30,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
