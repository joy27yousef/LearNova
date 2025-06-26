import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class CourseSkills extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  CourseSkills({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: controller.skills
          .map((skill) => Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Appcolor.base,
                ),
                child: Text(
                  skill,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Appcolor.backgroundLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                ),
              ))
          .toList(),
    );
  }
}
