import 'dart:convert';

import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/home/course.dart';

abstract class CourseController extends GetxController {
  onInit();
  getData();
}

class CourseControllerIMP extends CourseController {
  int? idCourse;
  late Statusrequest statusrequest;
  CourseData courseData = CourseData(crud: Get.find<Crud>());
  Map<String, dynamic> data = {};
  var isExpanded = false.obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    idCourse = Get.arguments['ID'];
    if (idCourse != null) {
      getData();
    } else {
      print("⚠️ courseID is null");
    }
    getData();
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  @override
  getData() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await courseData.getData("$idCourse");
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      if (response != null && response is Map<String, dynamic>) {
        data.clear();
        data.addAll(response);
      } else {
        print(" response is null or not a Map");
        statusrequest = Statusrequest.failure;
      }
    } else {
      print(" Failed to fetch course data");
    }

    update();
  }
}
