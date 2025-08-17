import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/course/courseBenefits.dart';
import 'package:learn_nova/views/widgets/course/courseDetailsInfo.dart';
import 'package:learn_nova/views/widgets/course/courseFAQ.dart';
import 'package:learn_nova/views/widgets/course/courseReviews.dart';
import 'package:learn_nova/views/widgets/course/courseskills.dart';
import 'package:learn_nova/views/widgets/course/description.dart';
import 'package:learn_nova/views/widgets/course/teacherDetails.dart';
import 'package:learn_nova/views/widgets/homePage/headerLine.dart';

class DescriptionPart extends StatelessWidget {
  const DescriptionPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '69'.tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 10,
        ),
        Description(),
        SizedBox(
          height: 20,
        ),
        CourseDetailsInfo(),
        SizedBox(
          height: 25,
        ),
        Text(
          '72'.tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 10,
        ),
        TeacherDetails(),
        SizedBox(
          height: 20,
        ),
        Text(
          "84".tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 15,
        ),
        CourseSkills(),
        SizedBox(
          height: 30,
        ),
        Text(
          "85".tr,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 7),
        CourseBenefits(),
        SizedBox(
          height: 30,
        ),
        Text("86".tr, style: Theme.of(context).textTheme.titleLarge),
        CourseFAQ(),
        SizedBox(
          height: 20,
        ),
        Headerline(
          hint1: '87'.tr,
          hint2: '45'.tr,
          onTapHeader: () {
            Get.toNamed(AppRoutes.allReviewinCourse);
          },
        ),
        CourseReviews(),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
