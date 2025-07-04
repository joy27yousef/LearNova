import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

class TeacherDetails extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  TeacherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      elevation: 0.5,
      shadowColor: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(Appimages.person),
        ),
        title: Text(
          controller.data['teacher']['name'],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          controller.data['teacher']['email'],
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
