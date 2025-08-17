import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/services/services.dart';
import 'package:learn_nova/data/source/remote/home/ExternalCourse.dart';
import 'package:learn_nova/data/source/remote/home/categories.dart';
import 'package:learn_nova/data/source/remote/home/trendingCourse.dart';

import 'package:learn_nova/data/source/static.dart';

abstract class Homepagecontroller extends GetxController {
  onChangeMessage(int x);
  getCourseData();
  getCategoryData();
  getTreandingCourses();
}

class HomepagecontrollerIMP extends Homepagecontroller {
  CategoriesData categoriesData = CategoriesData(crud: Get.find<Crud>());
  ExternalCourseData externalCourseData =
      ExternalCourseData(crud: Get.find<Crud>());
  TrendingCourseData trendingCourseData =
      TrendingCourseData(crud: Get.find<Crud>());

  late Statusrequest categoryStatusrequest;
  late Statusrequest trendingStatusrequest;
  late Statusrequest coursesStatusrequest;
  List maincategories = []; // parent Categories
  List dataCategory = []; //all data in cateory
  List dataCourse = []; //all data in cateory
  List subcategoriesWithAll = [];
  List treanding = [];
  List freeCourses = [];
  var selectedIndex = 0.obs;
  var selectedCategoryId = 0.obs;
  late PageController pageController;
  Timer? timer;
  MyServices myServices = Get.find();
  int currentcontent = 0;
  List newCourses = [];

  @override
  void onInit() {
    super.onInit();
    getCourseData();
    getCategoryData();
    getTreandingCourses();
    pageController = PageController();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (pageController.hasClients) {
        currentcontent = (currentcontent + 1) % homeScrol.length;
        pageController.animateToPage(
          currentcontent,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        update();
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    timer?.cancel();
    super.onClose();
  }

  Future<void> refreshHomeData() async {
    await Future.wait([
      getCourseData(),
      getCategoryData(),
      getTreandingCourses(),
    ]);
  }

  @override
  Future<void> getCourseData() async {
    coursesStatusrequest = Statusrequest.loading;
    update();
    var response = await externalCourseData.getData();
    coursesStatusrequest = handilingData(response);
    if (Statusrequest.success == coursesStatusrequest) {
      dataCourse.clear();
      dataCourse.addAll(response['data']);

      freeCourses.clear();
      freeCourses.addAll(
        response['data'].where((course) {
          double price = double.tryParse(course['price']) ?? 0.00;
          return price == 0.00;
        }).toList(),
      );

      newCourses.clear();
      newCourses.addAll(response['data']);

      newCourses.sort((a, b) {
        DateTime dateA = DateTime.parse(a['created_at']);
        DateTime dateB = DateTime.parse(b['created_at']);
        return dateB.compareTo(dateA);
      });

      List newestCourses = newCourses.take(8).toList();
      newCourses.clear();
      newCourses.addAll(newestCourses);
      print('✅success to get home course');
    } else {
      coursesStatusrequest = Statusrequest.failure;
    }
    update();
  }

  @override
  Future<void> getCategoryData() async {
    categoryStatusrequest = Statusrequest.loading;
    update();
    var response = await categoriesData.getData();
    categoryStatusrequest = handilingData(response);
    if (Statusrequest.success == categoryStatusrequest) {
      maincategories.clear();
      dataCategory.addAll(response['data']);
      maincategories.addAll(
          response['data'].where((element) => element['parent_id'] == null));
    } else {
      categoryStatusrequest = Statusrequest.failure;
    }
    update();
  }

//treanding
  Future<void> getTreandingCourses() async {
    trendingStatusrequest = Statusrequest.loading;
    update();

    var response = await trendingCourseData.getData();
    trendingStatusrequest = handilingData(response);

    if (Statusrequest.success == trendingStatusrequest) {
      treanding.clear();
      treanding.addAll(response['data']);
      treanding.sort((a, b) => (b['ratings_avg_rating'] as double)
          .compareTo(a['ratings_avg_rating'] as double));

      print('✅Success to get treanding');
    } else {
      trendingStatusrequest = Statusrequest.failure;
      print('❌error to get treanding');
    }
    update();
  }

  @override
  onChangeMessage(int index) {
    currentcontent = index;
    update();
  }

  void updateCoursesForMainCategory(int mainCategoryId) {
    selectedCategoryId.value = 0;
    selectedIndex.value = 0;
    update();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
