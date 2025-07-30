import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/screens/MycoursesPage/curriculcumInCourse.dart';
import 'package:learn_nova/views/screens/MycoursesPage/gradesPage.dart';
import 'package:learn_nova/views/widgets/course/descriptionPart.dart';
import 'package:learn_nova/views/screens/MycoursesPage/notesPage.dart';

class CourseLearning extends StatelessWidget {
  final MyCoursesControllerIMP myCoursesController = Get.find();

  CourseLearning({super.key});

  final List<String> titleScroll = ['Home', 'Grades', 'Notes', 'Info'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<CourseControllerIMP>();
        Get.delete<CoursepProgresscConteroller>();
        return true;
      },
      child: GetBuilder<CourseControllerIMP>(
        init: CourseControllerIMP(),
        builder: (controller) {
          return DefaultTabController(
            length: titleScroll.length,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 70,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PopupMenuButton<int>(
                        onSelected: (value) {
                          if (value == 0) {
                            Get.toNamed(AppRoutes.ratingPage, arguments: {
                              "courseId": controller.idCourse,
                              "courseImage": controller.data['thumbnail_url'],
                              "courseTitle": controller.data['title']
                                  [translationData()],
                            });
                          } else if (value == 1) {
                            controller.unEnroll(context);
                          }
                        },
                        icon: const Icon(Icons.more_vert),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Theme.of(context).colorScheme.background,
                        elevation: 8,
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber),
                                SizedBox(width: 10),
                                Text("Course evaluation"),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.logout_rounded, color: Colors.red),
                                SizedBox(width: 10),
                                Text("Unenroll"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  title: Text(
                    controller.data['title']?[translationData()] ?? 'Loading..',
                    key: const ValueKey('collapsedTitle'),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle!
                        .copyWith(fontSize: 16),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 0),
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          tabBarTheme: const TabBarTheme(
                            dividerColor: Colors.transparent,
                          ),
                        ),
                        child: TabBar(
                          indicatorColor: Appcolor.base,
                          labelColor: Appcolor.base,
                          unselectedLabelColor: Colors.grey,
                          indicatorWeight: 3,
                          tabs: List.generate(
                            titleScroll.length,
                            (i) => Tab(
                              child: Text(
                                titleScroll[i],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: Handilingdataview(
                  statusrequest: controller.statusrequest,
                  widget: TabBarView(
                    children: [
                      CurriculcumInCourse(),
                      Grades(),
                      AllNotesPage(),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            DescriptionPart(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
