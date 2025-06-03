import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/getGreeting.dart';

class Appbarhomepage extends StatelessWidget {
  final String name;
  const Appbarhomepage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(Appimages.person),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: getGreeting(),
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
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
          padding: const EdgeInsets.only(right: 25),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: () {
              Get.toNamed(AppRoutes.searhPage);
            },
            child: Image.asset(
              Appimages.search,
              width: 25,
            ),
          ),
        )
      ],
    );
  }
}
