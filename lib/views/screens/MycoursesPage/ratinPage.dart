import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/actionRatingAppBar.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/addReview.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/viewRating.dart';

class RatingPage extends StatelessWidget {
  final RatingController controller = Get.put(RatingController());
  RatingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
        title: GetBuilder<RatingController>(
          builder: (_) => Text(
            controller.userRating.isEmpty
                ? 'Rate your experience'
                : 'Your rating',
          ),
        ),
        actions: [
          ActionRatingAppBar(),
        ],
        centerTitle: true,
      ),
      body: GetBuilder<RatingController>(
        builder: (_) {
          return controller.userRating.isEmpty ? AddRating() : ViewRating();
        },
      ),
    );
  }
}
