import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/mycourses/ratings.dart';

class RatingController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  addRating rating = addRating(crud: Get.find<Crud>());
  deleteRating delete = deleteRating(crud: Get.find<Crud>());
  late Statusrequest statusrequest;
  final box = GetStorage();
  List<Map<String, dynamic>> userRating = [];
  double ratingNum = 0.0;
  late TextEditingController review;
  late int courseId;
  late String courseImage;
  late String courseTitle;

  @override
  void onInit() {
    super.onInit();
    courseId = Get.arguments['courseId'];
    courseImage = Get.arguments['courseImage'];
    courseTitle = Get.arguments['courseTitle'];
    var storedRating = box.read("rating_$courseId");
    if (storedRating != null) {
      userRating.add(Map<String, dynamic>.from(storedRating));
      print("📦the rating was loaded from local storage : $userRating");
    }
    review = TextEditingController();
  }

  addUserRating() async {
    if (formstate.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      update();
      var response = await rating.getData(courseId, ratingNum, review.text);
      statusrequest = handilingData(response);
      if (response['rating'] != null) {
        userRating.clear();
        userRating.add(response['rating']);
        box.write("rating_$courseId", response['rating']);
        showCustomSnackbar(
          title: "Thank you!",
          message: "Your rating has been submitted.",
          icon: Icons.star,
          backgroundColor: Colors.green,
        );
        print('✅ Rating submitted: $userRating');
      } else {
        print("❌ Failed to submit rating");
      }
      update();
    } else {
      print('Not valid');
    }
  }

  deleteUserRating() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await delete.getData(courseId, userRating[0]['id']);
    statusrequest = handilingData(response);
    if (userRating.isNotEmpty) {
      userRating.clear();
      update();
      print("🗑️ Rating deleted locally.");
      box.remove("rating_$courseId");
      showCustomSnackbar(
        title: "Rating removed",
        message: "Your feedback has been deleted.",
        icon: Icons.delete_forever,
        backgroundColor: Colors.red,
      );
      print('✅ Rating delete: $response');
    } else {
      print("❌ Failed to submit rating");
    }
  }
}
