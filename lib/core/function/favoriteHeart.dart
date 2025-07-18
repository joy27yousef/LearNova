import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/profile/favoritesCoursesController.dart';
import 'package:like_button/like_button.dart';

class FavoriteHeart extends StatelessWidget {
  final int courseId;
  final FavoritesCoursesController favcontroller = Get.find();
  FavoriteHeart({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(() => LikeButton(
              size: 35,
              animationDuration: Duration(milliseconds: 1100),
              isLiked: favcontroller.favoriteIds.contains(courseId),
              onTap: (isLiked) async {
                if (isLiked) {
                  await favcontroller.removeFromFavorites(courseId);
                } else {
                  await favcontroller.addToFavorites(courseId);
                }
                return favcontroller.favoriteIds.contains(courseId);
              },
            )));
  }
}
