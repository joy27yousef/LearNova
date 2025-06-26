import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';

class CourseBenefits extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  CourseBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: controller.benefits
            .map((benefit) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 8,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          benefit,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
