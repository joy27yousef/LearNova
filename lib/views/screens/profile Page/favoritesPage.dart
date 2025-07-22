import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/profile/favoritesCoursesController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/views/widgets/profile/favoriteCard.dart';
import 'package:lottie/lottie.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GetBuilder<FavoritesCoursesController>(
          builder: (controller) {
            if (controller.statusrequest == Statusrequest.loading) {
              return Center(child: Lottie.asset(Appimages.loading2));
            }

            if (controller.data.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "No favorites yet.",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              );
            }
            return FavoriteCard();
          },
        ),
      ),
    );
  }
}
