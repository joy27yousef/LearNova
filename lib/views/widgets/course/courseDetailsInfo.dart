import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/levelGEN.dart';
import 'package:learn_nova/core/function/translationData.dart';

class CourseDetailsInfo extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  CourseDetailsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            Appimages.chapter,
            width: 28,
          ),
          title: Row(
            children: [
              Text(
                "${controller.sections.length} ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              Text(
                "73".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
          subtitle: Text('74'.tr),
        ),
        ListTile(
          leading: Image.asset(
            Appimages.translation,
            width: 25,
          ),
          title: Text(
            controller.data['default_language'],
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          subtitle: Text('75'.tr),
        ),
        ListTile(
          leading: Image.asset(
            Appimages.speedometer,
            width: 25,
          ),
          title: Row(
            children: [
              Text(
                "${controller.data['difficulty_level']} ",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              Text(
                "76".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
          subtitle: Text(levelGen(controller.data['difficulty_level'])),
        ),
        ListTile(
          leading: Image.asset(
            Appimages.duration,
            width: 25,
          ),
          title: Row(
            children: [
              Text(
                '78'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              Text(
                ' ${controller.data['duration'][translationData()]} ',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
              Text(
                '79'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
          subtitle: Text('80'.tr),
        ),
        ListTile(
          leading: Image.asset(
            Appimages.online_education,
            width: 25,
          ),
          title: Text(
            "81".tr,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          subtitle: Text('82'.tr),
        ),
        ListTile(
          leading: Image.asset(
            Appimages.access,
            width: 25,
          ),
          title: Text(
            "83".tr,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          subtitle: Text('77'.tr),
        ),
      ],
    );
  }
}
