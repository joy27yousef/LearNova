import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/data/source/remote/home/course.dart';

abstract class CourseController extends GetxController {
  getData();
}

class CourseControllerIMP extends CourseController {
  CourseData courseData = CourseData(crud: Get.find<Crud>());
  CourseEnrollData courseEnroll = CourseEnrollData(crud: Get.find<Crud>());
  CourseUnEnrollData courseUnEnroll =
      CourseUnEnrollData(crud: Get.find<Crud>());
  Statusrequest statusrequest = Statusrequest.none;
  Map<String, dynamic> data = {};
  RxList skills = [].obs;
  RxList benefits = [].obs;
  RxList sections = [].obs;
  int? idCourse;
  var isExpanded = false.obs;
  var selectedIndex = 0.obs;
  RxnInt selectedIndexfaq = RxnInt();
  RxList<Map<String, String>> faqs = <Map<String, String>>[].obs;
  RxBool isEnrolled = false.obs;
  List get videosOfSelectedModule {
    if (sections.isEmpty) return [];
    var currentSection = sections[selectedIndex.value];
    if (currentSection == null) return [];
    return currentSection['videos'] ?? [];
  }

  @override
  void onInit() {
    super.onInit();
    idCourse = Get.arguments['ID'];
    if (idCourse != null) {
      getData();
      Future.delayed(Duration.zero, () async {
        int uid = Get.find<UserControllerIMP>().userId.value;
        await Get.find<MyCoursesControllerIMP>().getMyCourses(uid);
        checkEnrollment();
      });
    } else {
      print("⚠️ courseID is null");
    }
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
        sections.value = data['sections'] ?? [];

        if (Get.isRegistered<CoursepProgresscConteroller>()) {
          var progressController = Get.find<CoursepProgresscConteroller>();
          await progressController.loadWatchedVideos();
          await progressController.loadCourseProgress();
        }
        checkEnrollment();
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

  @override
  enroll() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await courseEnroll.getData("$idCourse");
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      checkEnrollment();
      showCustomSnackbar(
        title: "Registration has been successfully completed",
        message: "The course was added to My Courses.",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
    } else {
      showCustomSnackbar(
        title: "Failed course registration",
        message: "Try again..",
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
    }

    update();
  }

  @override
  unEnroll(BuildContext context) async {
    statusrequest = Statusrequest.loading;
    update();
    showLoadingDialog();
    var response = await courseUnEnroll.getData("$idCourse");
    print(response);
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      // alert(context, Appimages.success,
      //     'The course registration process was successfully completed');
      checkEnrollment();
    } else {
      print("Failed to fetch course data");
      // alert(
      //     context, Appimages.failure, 'Failed the course registration process');
    }

    update();
  }

  void checkEnrollment() {
    final userCourses = Get.find<MyCoursesControllerIMP>().data;
    isEnrolled.value =
        userCourses.any((course) => course['courseId'] == idCourse);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
