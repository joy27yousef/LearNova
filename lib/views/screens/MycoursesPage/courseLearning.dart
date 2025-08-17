import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';

import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/screens/MycoursesPage/curriculcumInCourse.dart';
import 'package:learn_nova/views/screens/MycoursesPage/gradesDone.dart';
import 'package:learn_nova/views/screens/MycoursesPage/gradesPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/notesPage.dart';
import 'package:learn_nova/views/widgets/course/descriptionPart.dart';

class CourseLearning extends StatefulWidget {
  const CourseLearning({super.key});

  @override
  State<CourseLearning> createState() => _CourseLearningState();
}

class _CourseLearningState extends State<CourseLearning>
    with TickerProviderStateMixin {
  final MyCoursesControllerIMP myCoursesController = Get.find();

  final List<String> titleScroll = ['Home', 'Grades', 'Notes', 'Info'];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    int initialTabIndex = Get.arguments?['tabIndex'] ?? 0;
    tabController = TabController(
      length: titleScroll.length,
      vsync: this,
      initialIndex: initialTabIndex,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<CourseControllerIMP>();
        Get.delete<CoursepProgresscConteroller>();
        return true;
      },
      child: WillPopScope(
        onWillPop: () async {
          Get.find<MainpagecontrollerIMP>().changePage(1);
          Get.offAllNamed(AppRoutes.mainPage);
          return false;
        },
        child: GetBuilder<CourseControllerIMP>(
          init: CourseControllerIMP(),
          builder: (controller) {
            return Container(
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
                            confirmationAelrt(
                                Appimages.cancel,
                                'Do you really want to cancel the course registration??\n you will lose your subscription to the course',
                                'No, keep the record',
                                'Unenroll',
                                Colors.red, () {
                              controller.unEnroll(context);
                            });
                          }
                        },
                        icon: const Icon(Icons.more_vert),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Theme.of(context).colorScheme.background,
                        elevation: 8,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(
                                  Iconsax.star,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Rating",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Iconsax.trash),
                                SizedBox(width: 10),
                                Text(
                                  "Un Enroll",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                ),
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
                    onPressed: () {
                      Get.find<MainpagecontrollerIMP>().changePage(1);
                      Get.offAllNamed(AppRoutes.mainPage);
                    },
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
                          controller: tabController,
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
                    statusrequests: [controller.statusrequest],
                  widget: TabBarView(
                    controller: tabController,
                    children: [
                      CurriculcumInCourse(),
                      controller.hasAttempt ? GradesDone() : Grades(),
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
            );
          },
        ),
      ),
    );
  }
}
