import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/views/widgets/course/description.dart';

class BaseView2 extends StatelessWidget {
  BaseView2({super.key});
  CourseControllerIMP controller = Get.put(CourseControllerIMP());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final views = [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "description",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Description(),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Image.asset(
                Appimages.translation,
                width: 30,
              ),
              title: Text(
                controller.data['default_language'],
              ),
              subtitle: Text('and mor than 25 langouage'),
            ),
            ListTile(
              leading: Image.asset(
                Appimages.translation,
                width: 30,
              ),
              title: Text(
                controller.data['default_language'],
              ),
              subtitle: Text('time'),
            ),
            ListTile(
              leading: Image.asset(
                Appimages.translation,
                width: 30,
              ),
              title: Text(
                controller.data['default_language'],
              ),
              subtitle: Text('shahade'),
            ),
            ListTile(
              leading: Image.asset(
                Appimages.certificate,
                width: 30,
              ),
              title: Text('English'),
              subtitle: Text('acsess'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "skills",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 170,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 7,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.7,
                ),
                itemBuilder: (context, i) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Appcolor.base, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Appcolor.baselight2),
                  child: Center(
                      child: Text(
                    'slkills',
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Appcolor.base, fontWeight: FontWeight.normal),
                  )),
                ),
              ),
            ),
            Text(
              "The most important benefits gained from the course",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
        Text("This is the Review section",
            style: Theme.of(context).textTheme.bodyLarge),
      ];

      return AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: Container(
          key: ValueKey(controller.selectedIndex.value),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: views[controller.selectedIndex.value],
        ),
      );
    });
  }
}
