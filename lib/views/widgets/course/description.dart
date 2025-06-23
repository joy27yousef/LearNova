import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/function/translationData.dart';
import '../../../core/constant/AppFont.dart';

class Description extends StatelessWidget {
  Description({super.key});
  CourseControllerIMP controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.data['description'][translationData()],
            maxLines: controller.isExpanded.value ? null : 3,
            overflow: controller.isExpanded.value
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                  fontFamily: AppFonts.Poppins,
                ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: controller.toggleExpanded,
            child: Text(
              controller.isExpanded.value ? 'read less' : 'Read more',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.Poppins,
              ),
            ),
          ),
        ],
      );
    });
  }
}
