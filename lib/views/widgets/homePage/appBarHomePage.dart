import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/getGreeting.dart';
import 'package:marquee/marquee.dart';

class Appbarhomepage extends StatelessWidget {
  final userController = Get.find<UserControllerIMP>();

  Appbarhomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 20, top: 8),
                  child: Obx(() {
                    final user = userController.user;
                    if (user.isEmpty || user['profile_image'] == null) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(Appimages.person),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user['profile_image']),
                      );
                    }
                  }),
                ),
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
                        text: userController.user['first_name'] ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 30),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Get.toNamed(AppRoutes.searhPage);
                },
                child: Image.asset(
                  Appimages.search,
                  width: 30,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 25,
          child: Marquee(
            text: userController.user['bio'] ?? '',
            style: Theme.of(context).textTheme.titleMedium,
            scrollAxis: Axis.horizontal,
            blankSpace: 50.0,
            velocity: 40.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        )
      ],
    );
  }
}
