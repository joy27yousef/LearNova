import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/SearchController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/favoriteHeart.dart';
import 'package:lottie/lottie.dart';

class DataSearch extends StatelessWidget {
  const DataSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<SearchCourseController>(
        builder: (controller) {
          if (controller.statusrequest == Statusrequest.loading) {
            return Center(child: Lottie.asset(Appimages.loading2));
          }
          if (controller.filteredCourses.isEmpty) {
            if (controller.searchText.trim().isEmpty) {
              return Center(
                  child: Text(
                'Find courses to show here',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
              ));
            } else {
              return Center(child: Text('There are no matching courses'));
            }
          }

          return ListView.builder(
            itemCount: controller.filteredCourses.length,
            itemBuilder: (context, index) {
              final course = controller.filteredCourses[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.coursePage, arguments: {
                    'ID': course.id,
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
                            imageUrl: course.thumbnailurl,
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
                                course.title,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "By ${course.teacher}",
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
                                  Text(course.difficulty_level,
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
                                  Text("${course.duration}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      " 24.00 \$",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  FavoriteHeart(
                                    courseId: course.id,
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
        },
      ),
    );
  }
}
// Card(
//                 margin: EdgeInsets.symmetric(vertical: 6),
//                 child: ListTile(
//                   title: Text(course.title),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Text('المدة: ${course.duration}'),
//                     ],
//                   ),
//                 ),
//               );
