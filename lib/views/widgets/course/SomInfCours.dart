import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

class SomInfCours extends StatelessWidget {
  SomInfCours({super.key});
  CourseControllerIMP controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.yellow.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(Appimages.teamwork),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Row(
                children: [
                  Text(
                    "2.3K ",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    "66".tr,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.yellow.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(Appimages.rating),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "4.5",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
