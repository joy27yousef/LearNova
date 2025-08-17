import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/categoryController.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/core/class/animatedListItem.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/favoriteHeart.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:lottie/lottie.dart';

class CourseViewinMainCat extends StatelessWidget {
  final int mainCategoryId = Get.arguments['mainCategoryId'];
  CourseViewinMainCat({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepagecontrollerIMP controller = Get.put(HomepagecontrollerIMP());
    return Expanded(child: AnimatedListItem(
      child: Obx(() {
        final filteredCourses = controller.selectedCategoryId.value == 0
            ? controller.dataCourse
                .where((course) =>
                    course['category']?['parent_id'] == mainCategoryId)
                .toList()
            : controller.dataCourse
                .where((course) =>
                    course['category_id'] ==
                    controller.selectedCategoryId.value)
                .toList();

        if (filteredCourses.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Appimages.noData,
                width: 200,
              ),
              Center(
                child: Text(
                  'There are no courses yet..',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        }

        return ListView.builder(
          primary: false,
          itemCount: filteredCourses.length,
          itemBuilder: (context, i) {
            final course = filteredCourses[i];
            return InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.coursePage, arguments: {
                  'ID': filteredCourses[i]['id'],
                  'needQuiz': false
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.shade300,
                    )
                  ],
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 115,
                      height: 145,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: CachedNetworkImage(
                          imageUrl: course['thumbnail_url'],
                          placeholder: (context, url) =>
                              Center(child: Lottie.asset(Appimages.loading2)),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              course['title'][translationData()],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "By ${course['teacher']['first_name']} ${course['teacher']['last_name']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  // child: Image.asset(
                                  //   Appimages.rating,
                                  //   width: 20,
                                  // ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Lottie.asset(
                                  Appimages.advantage,
                                  width: 25,
                                ),
                                SizedBox(width: 5),
                                Text(course['difficulty_level'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Lottie.asset(
                                  Appimages.time,
                                  width: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                    "  ${course['duration'][translationData()]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                      course['price'] == "0.00"
                                          ? "Free"
                                          : "${course['price']} SYP",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.green,
                                              fontSize: 16)),
                                ),
                                FavoriteHeart(
                                  courseId: course['id'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    ));
  }
}
