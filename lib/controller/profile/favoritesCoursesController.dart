import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/profile/favoritesCoursesData.dart';

class FavoritesCoursesController extends GetxController {
  late Statusrequest statusrequest;

  AddToFavoritesData addToFavoritesData =
      AddToFavoritesData(crud: Get.find<Crud>());
  RemoveFromFavoritesData removeFromFavoritesData =
      RemoveFromFavoritesData(crud: Get.find<Crud>());
  ViewFavoritesData viewFavoritesData =
      ViewFavoritesData(crud: Get.find<Crud>());
  CheckFavoritesData checkFavoritesData =
      CheckFavoritesData(crud: Get.find<Crud>());

  RxList<int> favoriteIds = <int>[].obs;
  List data = [];

  addToFavorites(courseId) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await addToFavoritesData.getData(courseId);
    statusrequest = handilingData(response);

    if (Statusrequest.success == statusrequest) {
      if (!favoriteIds.contains(courseId)) {
        favoriteIds.add(courseId);
      }

      showCustomSnackbar(
        title: "Successfully added to the favorit",
        message: "Go to the profile to browse your favorite courses",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );

      print('✅ add to favorites');

      // ⬇️ تحديث القائمة بعد الإضافة
      await viewFavorites();
    } else {
      print("❌ Failed to add to favorites");
    }

    update();
  }

  removeFromFavorites(courseId) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await removeFromFavoritesData.getData(courseId);
    statusrequest = handilingData(response);

    if (Statusrequest.success == statusrequest) {
      favoriteIds.remove(courseId);

      showCustomSnackbar(
        title: "Successfully removed from the favorit",
        message: "Course removed from the favorites page",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );

      print('✅ remove from favorites');

      // ⬇️ تحديث القائمة بعد الحذف
      await viewFavorites();
    } else {
      print("❌ Failed to remove from favorites");
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    viewFavorites();
  }

  viewFavorites() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await viewFavoritesData.getData();
    statusrequest = handilingData(response);
    if (Statusrequest.success == statusrequest) {
      favoriteIds.assignAll(
          List<int>.from(response['data'].map((course) => course['id'])));
      data.clear();
      data.addAll(response['data']);
      print('✅ loaded favorites');
    } else {
      print("❌ Failed to load favorites");
    }
    update();
  }

  // checkFavCourse(courseId) async {
  //   statusrequest = Statusrequest.loading;
  //   update();
  //   var response = await checkFavoritesData.getData(courseId);
  //   statusrequest = handilingData(response);
  //   if (Statusrequest.success == statusrequest) {
  //     if (response['is_saved'] == true) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //     print('✅ loaded favorites');
  //   } else {
  //     print("❌ Failed to load favorites");
  //   }
  //   update();
  // }
}
