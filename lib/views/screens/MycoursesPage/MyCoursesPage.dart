import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/core/class/AnimatedListItem.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:lottie/lottie.dart';

class Mycoursespage extends StatelessWidget {
  MyCoursesControllerIMP controller = Get.put(MyCoursesControllerIMP());
  Mycoursespage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => alerExitApp(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Courses'),
        ),
        body: GetBuilder<MyCoursesControllerIMP>(
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, i) {
                var course = controller.data[i];
                return FutureBuilder<double>(
                  future: controller.loadCourseProgress(course['courseId']),
                  builder: (context, snapshot) {
                    double progress = snapshot.data ?? 0.0;

                    return AnimatedListItem(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                              color: Colors.grey.shade300,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 500,
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: course['courseThumbnailUrl'],
                                  placeholder: (context, url) => Center(
                                      child: Lottie.asset(Appimages.loading2)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                course['courseTitle']['en'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 16),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(course['categoryName']['en']),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LinearProgressIndicator(
                                    value: progress / 100,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getProgressColor(progress),
                                    ),
                                    minHeight: 12,
                                  ),
                                  const SizedBox(height: 6),
                                  Text("${progress.toStringAsFixed(1)}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ],
                              ),
                            ),

                            // زر الدخول للكورس
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.learningCourse,
                                            arguments: {
                                              'ID': course['courseId'],
                                            });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Appcolor.base,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Go to course',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Color _getProgressColor(double progress) {
  if (progress < 30) {
    return Colors.red;
  } else if (progress < 70) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}
