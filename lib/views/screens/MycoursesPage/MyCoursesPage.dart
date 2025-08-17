import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/core/class/animatedListItem.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
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
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshCourses();
              },
              child: Handilingdataview(
                statusrequests: [controller.statusrequest],
                widget: controller.data.isEmpty
                    ? SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 500,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Appimages.noData, height: 200),
                                const SizedBox(height: 20),
                                Text(
                                  "There are no registered courses",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.data.length,
                        itemBuilder: (context, i) {
                          var course = controller.data[i];
                          return FutureBuilder<double>(
                            future: controller
                                .loadCourseProgress(course['courseId']),
                            builder: (context, snapshot) {
                              double progress = snapshot.data ?? 0.0;

                              return AnimatedListItem(
                                child: course['status'] == 'pending'
                                    ? InkWell(
                                        onTap: () async {
                                          String status =
                                              await controller.paymentStatus(
                                                  context, course['courseId']);
                                          if (status.toLowerCase() ==
                                              'pending') {
                                            showCustomSnackbar(
                                              title: 'Payment is pending',
                                              message:
                                                  'Access will be enabled after teacher confirmation',
                                              icon: Icons.hourglass_empty,
                                              backgroundColor: Colors.orange,
                                            );
                                          } else if (status.toLowerCase() ==
                                              'accepted') {
                                            Get.toNamed(
                                                AppRoutes.learningCourse,
                                                arguments: {
                                                  'ID': course['courseId'],
                                                });
                                            showCustomSnackbar(
                                              title: 'Payment Confirmed',
                                              message:
                                                  'You now have access to the course!',
                                              icon: Icons.check_circle,
                                              backgroundColor: Colors.green,
                                            );
                                          } else {
                                            showCustomSnackbar(
                                              title: 'Unknown Status',
                                              message:
                                                  'Could not verify payment.',
                                              icon: Icons.error_outline,
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 15,
                                                  blurStyle: BlurStyle.outer,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground)
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    width: double.infinity,
                                                    margin: EdgeInsets.all(10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: course[
                                                            'courseThumbnailUrl'],
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child: Lottie.asset(
                                                                    Appimages
                                                                        .loading2)),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      course['courseTitle']
                                                          ['en'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                            fontSize: 16,
                                                          ),
                                                    ),
                                                    subtitle: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Text(
                                                        course['categoryName']
                                                            ['en'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontSize: 12,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                ],
                                              ),
                                              Positioned(
                                                top: 12,
                                                right: 12,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.orangeAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    'Pending',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.learningCourse,
                                              arguments: {
                                                'ID': course['courseId'],
                                              });
                                        },
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5,
                                                  blurStyle: BlurStyle.outer,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground)
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 120,
                                                width: 500,
                                                margin: EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: course[
                                                        'courseThumbnailUrl'],
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child: Lottie.asset(
                                                                Appimages
                                                                    .loading2)),
                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Text(
                                                      course['categoryName']
                                                          ['en']),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    LinearProgressIndicator(
                                                      value: progress / 100,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        _getProgressColor(
                                                            progress),
                                                      ),
                                                      minHeight: 12,
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                        "${progress.toStringAsFixed(1)}%",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                                fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              );
                            },
                          );
                        },
                      ),
              ),
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
