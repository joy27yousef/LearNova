import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/views/widgets/homePage/trandingCourses.dart';

class AllTrendingCourse extends StatelessWidget {
  HomepagecontrollerIMP controller = Get.find();
  AllTrendingCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trending Courses'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: TrandingCourses(
              num: controller.treanding.length,
              scrollDirection: Axis.vertical, imageheight: 130,
            ))
          ],
        ));
  }
}
