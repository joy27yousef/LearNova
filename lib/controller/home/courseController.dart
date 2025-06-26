import 'dart:convert';

import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/translationData.dart';
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
  RxList skills = [].obs;
  RxList benefits = [].obs;
  RxList sections = [].obs;
  RxnInt selectedIndexfaq = RxnInt();
  RxList<Map<String, String>> faqs = <Map<String, String>>[].obs;

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
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  @override
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
        try {
          var rawSkills = data['skills'] ?? [];
          skills.value = List.from(rawSkills.map((skill) {
            var name = skill['name'];
            if (name is Map && name.containsKey(translationData())) {
              return name[translationData()];
            } else {
              return name.toString();
            }
          }));
          var rawBenefits = data['benefits'] ?? [];
          benefits.value = List.from(rawBenefits.map((benefit) {
            var title = benefit['title'];
            if (title is Map && title.containsKey(translationData())) {
              return title[translationData()];
            } else {
              return title?.toString() ?? '';
            }
          }));
          parseFaqs(data['faqs'] ?? []);
          sections.value = data['sections'] ?? [];
        } catch (e) {
          print("❌ Error parsing course data: $e");
          statusrequest = Statusrequest.failure;
        }
      } else {
        print("❌ Response is null or not a Map");
        statusrequest = Statusrequest.failure;
      }
    } else {
      print("❌ Failed to fetch course data");
    }

    update();
  }

  void parseFaqs(List faqsData) {
    faqs.value = faqsData.map<Map<String, String>>((faq) {
      return {
        'question': faq['question']?[translationData()] ?? '',
        'answer': faq['answer']?[translationData()] ?? '',
      };
    }).toList();
  }
}
