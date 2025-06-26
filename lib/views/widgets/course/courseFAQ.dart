import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class CourseFAQ extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  CourseFAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.faqs.length,
      itemBuilder: (context, index) {
        final faq = controller.faqs[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              collapsedBackgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconColor: Appcolor.base,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              title: Text(
                faq['question']!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                    ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    faq['answer']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
