import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/data/source/remote/home/course.dart';
import 'package:learn_nova/data/source/remote/mycourses/notes.dart';

abstract class CourseController extends GetxController {
  getData();
}

class CourseControllerIMP extends CourseController {
  late TextEditingController title;

  late TextEditingController content;
  CourseData courseData = CourseData(crud: Get.find<Crud>());
  CourseEnrollData courseEnroll = CourseEnrollData(crud: Get.find<Crud>());
  DeleteNotesData deleteNotesData = DeleteNotesData(crud: Get.find<Crud>());
  CourseUnEnrollData courseUnEnroll =
      CourseUnEnrollData(crud: Get.find<Crud>());

  Statusrequest statusrequest = Statusrequest.none;
  ViewNotesData viewNotesData = ViewNotesData(crud: Get.find<Crud>());
  AddNotesData addNotesData = AddNotesData(crud: Get.find<Crud>());
  RxList allNotes = [].obs;
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
    title = TextEditingController();
    content = TextEditingController();
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
        getAllNotes(idCourse);
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
  enroll(BuildContext context) async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog(context, 'm12'.tr);
    update();
    var response = await courseEnroll.getData("$idCourse");
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      checkEnrollment();
      showCustomSnackbar(
        title: "Registration has been successfully completed",
        message: "The course was added to My Courses.",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(milliseconds: 300), () {
        Get.toNamed(AppRoutes.learningCourse, arguments: {
          'ID': idCourse,
        });
      });
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
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
    // showLoadingDialog();
    var response = await courseUnEnroll.getData("$idCourse");
    print(response);
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      showCustomSnackbar(
        title: "Registration has been successfully canceled ",
        message: "We hope you have benefited from the course",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
      checkEnrollment();
    } else {
      print("Failed to fetch course data");
      showCustomSnackbar(
        title: "Successful cancellation of registration failed",
        message: "Try again",
        icon: Icons.done,
        backgroundColor: Colors.red,
      );
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

  getAllNotes(idCourse) async {
    statusrequest = Statusrequest.loading;

    update();
    var response = await viewNotesData.getData(idCourse);
    statusrequest = handilingData(response);
    update();
    if (Statusrequest.success == statusrequest) {
      allNotes.clear();
      if (response['data'] is List) {
        allNotes.addAll(response['data']);
      }
      print("✅ success to get notes");
    } else {
      print("❌ Failed to get notes");
      statusrequest = Statusrequest.failure;
    }
    update();
  }

  addNote(BuildContext context) async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog(context, 'adding the not..');
    update();
    var response = await addNotesData.getData(idCourse!, content.text, null);
    statusrequest = handilingData(response);
    update();
    if (Statusrequest.success == statusrequest) {
      getAllNotes(idCourse);
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("✅ success to add notes");
      content.clear();
      Get.back();
      showCustomSnackbar(
        title: "The note has been successfully added",
        message: "You can edit and delete it",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("❌ Failed to add notes");
      showCustomSnackbar(
        title: "Failed to add a note",
        message: "tray again !",
        icon: Icons.done,
        backgroundColor: Colors.red,
      );

      statusrequest = Statusrequest.failure;
    }
    update();
  }

  deleteNote(BuildContext context, int noteId) async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog(context, 'seleting the note..');
    update();
    var response = await deleteNotesData.getData(noteId);
    statusrequest = handilingData(response);
    update();
    if (Statusrequest.success == statusrequest) {
      getAllNotes(idCourse);
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("✅ success to delete notes");
      content.clear();

      showCustomSnackbar(
        title: "The note has been successfully deleted",
        message: "",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("❌ Failed to delete notes");
      showCustomSnackbar(
        title: "Failed to delete a note",
        message: "try again !",
        icon: Icons.done,
        backgroundColor: Colors.red,
      );

      statusrequest = Statusrequest.failure;
    }
    update();
  }
}
