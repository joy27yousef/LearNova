import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/mycourses/ratings.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/addReview.dart';

class RatingController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  addRatingData rating = addRatingData(crud: Get.find<Crud>());
  deleteRatingData delete = deleteRatingData(crud: Get.find<Crud>());
  EditRatingData edit = EditRatingData(crud: Get.find<Crud>());
  GetMyRatingData getMyRating = GetMyRatingData(crud: Get.find<Crud>());

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

    review = TextEditingController();
    fetchMyRating();
  }

  Future<void> fetchMyRating() async {
    statusrequest = Statusrequest.loading;
    update();

    var result = await getMyRating.getData(courseId, ratingNum, review.text);

    result.fold(
      (failure) {
        statusrequest = failure;
        userRating.clear();
        print("❌ Failed to fetch rating: $failure");
        Get.toNamed(AppRoutes.addRatingPage);
      },
      (data) {
        statusrequest = Statusrequest.success;

        if (data['rating'] != null) {
          userRating.clear();
          userRating.add(data['rating']);
          Get.toNamed(AppRoutes.viewRatingPage);
          print("📡 Rating fetched: $userRating");
        } else if (data['message'] == "No rating found") {
          userRating.clear();
          print("ℹ️ No rating found");
        }
      },
    );
  }

  addUserRating() async {
    if (formstate.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      showLoadingDialog('m2'.tr);
      update();
      var response = await rating.getData(courseId, ratingNum, review.text);
      statusrequest = handilingData(response);
      if (response['rating'] != null) {
        userRating.clear();
        userRating.add(response['rating']);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.offAndToNamed(AppRoutes.viewRatingPage);
        showCustomSnackbar(
          title: "Thank you!",
          message: "Your rating has been submitted.",
          icon: Icons.star,
          backgroundColor: Colors.green,
        );
        print('✅ Rating submitted: $userRating');
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        print("❌ Failed to submit rating");
      }
      update();
    } else {
      print('Not valid');
    }
  }

  deleteUserRating() async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog('m2'.tr);
    update();
    var response = await delete.getData(courseId, userRating[0]['id']);
    statusrequest = handilingData(response);
    if (userRating.isNotEmpty) {
      userRating.clear();
      update();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.back();
      Get.back();
      Get.back();

      showCustomSnackbar(
        title: "Rating removed",
        message: "Your feedback has been deleted.",
        icon: Icons.delete_forever,
        backgroundColor: Colors.red,
      );
      print('✅ Rating delete: $response');
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("❌ Failed to delete rating");
    }
  }

  editUserRating() async {
    if (formstate.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      showLoadingDialog('m2'.tr);
      update();

      final ratingId = userRating[0]['id'];
      var response =
          await edit.getData(courseId, ratingId, ratingNum, review.text);
      statusrequest = handilingData(response);

      if (response['rating'] != null) {
        userRating.clear();
        userRating.add(response['rating']);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.back();
        Get.back();

        showCustomSnackbar(
          title: "Updated!",
          message: "Your rating has been updated.",
          icon: Icons.edit,
          backgroundColor: Colors.blue,
        );

        print('✅ Rating updated: $userRating');
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        print("❌ Failed to update rating");
      }
      update();
    } else {
      print('Not valid');
    }
  }
}
