import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/views/widgets/homePage/viewCoursesHomePage.dart';

class AllFreeCourses extends StatelessWidget {
  HomepagecontrollerIMP controller = Get.find();
  AllFreeCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Courses'),
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
              child: Viewcourseshomepage(
                  scrollDirection: Axis.vertical,
                  imageheight: 130,
                  courses: controller.freeCourses,
                  num: controller.freeCourses.length))
        ],
      ),
    );
  }
}
