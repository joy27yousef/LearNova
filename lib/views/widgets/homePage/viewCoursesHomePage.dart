import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/core/class/animatedListItem.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/favoriteHeart.dart';
import 'package:learn_nova/core/function/translationData.dart';

class Viewcourseshomepage extends StatelessWidget {
  final Axis scrollDirection;
  final double imageheight;
  final int num;
  final List courses;
  const Viewcourseshomepage(
      {super.key,
      required this.scrollDirection,
      required this.imageheight,
      required this.courses,
      required this.num});

  @override
  Widget build(BuildContext context) {
    return AnimatedListItem(
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemCount: num,
        itemBuilder: (context, i) {
          final course = courses[i];
          return InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            onTap: () {
              Get.toNamed(AppRoutes.coursePage,
                  arguments: {'ID': course['id'], 'needQuiz': false});
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // صورة الكورس
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: course['thumbnail_url'],
                            height: imageheight,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: Icon(Icons.broken_image,
                                  size: 40, color: Colors.grey),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // العنوان
                        Text(
                          course['title'][translationData()],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 5),

                        // اسم المدرس
                        Text(
                          "By ${course['teacher']['first_name']} ${course['teacher']['last_name']}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  course['difficulty_level'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 3),
                                Icon(Iconsax.level,
                                    color: Appcolor.base, size: 16),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  course['duration'][translationData()],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 3),
                                Icon(Iconsax.timer,
                                    color: Appcolor.base, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course['price'] == '0.00'
                                ? 'Free'
                                : "${course['price']} SPY",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 15, color: Colors.green),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FavoriteHeart(courseId: course['id']),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
