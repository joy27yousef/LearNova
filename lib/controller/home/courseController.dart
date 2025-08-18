import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/mainPageController.dart';
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
import 'package:learn_nova/data/source/remote/mycourses/progressCourse.dart';
import 'package:learn_nova/data/source/remote/mycourses/quiz.dart';

abstract class CourseController extends GetxController {
  getData();
}

class CourseControllerIMP extends CourseController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController noteTitle;

  late TextEditingController content;
  ViewVideoNotesData viewVideoNotesData =
      ViewVideoNotesData(crud: Get.find<Crud>());

  RxList allVideoNotes = <Map<String, dynamic>>[].obs;
  CourseData courseData = CourseData(crud: Get.find<Crud>());
  CourseEnrollData courseEnroll = CourseEnrollData(crud: Get.find<Crud>());
  DeleteNotesData deleteNotesData = DeleteNotesData(crud: Get.find<Crud>());
  CourseUnEnrollData courseUnEnroll =
      CourseUnEnrollData(crud: Get.find<Crud>());

  Statusrequest statusrequest = Statusrequest.none;
  ViewNotesData viewNotesData = ViewNotesData(crud: Get.find<Crud>());
  AddNotesData addNotesData = AddNotesData(crud: Get.find<Crud>());
  EditNotesData editNotesData = EditNotesData(crud: Get.find<Crud>());

  RxList allNotes = [].obs;

  Map<String, dynamic> data = {};
  RxList skills = [].obs;
  RxList benefits = [].obs;
  RxList sections = [].obs;
  int? idCourse;
  Map<String, dynamic> checkdata = {};

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
  Future<void> onInit() async {
    super.onInit();
    title = TextEditingController();
    content = TextEditingController();
    noteTitle = TextEditingController();
    idCourse = Get.arguments['ID'];

    // الحالة الافتراضية true يعني دايمًا يجيب Quiz إلا إذا طلبت تعطيله
    bool needQuiz = Get.arguments['needQuiz'] ?? true;

    if (idCourse != null) {
      getData();

      Future.delayed(Duration.zero, () async {
        int uid = Get.find<UserControllerIMP>().user['id'];
        await Get.find<MyCoursesControllerIMP>().getMyCourses(uid);
        checkEnrollment();
      });

      if (needQuiz) {
        getQuizesData();
      }
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
        allNotes.clear();
        await getAllNotes(idCourse);

        if (Get.isRegistered<CoursepProgresscConteroller>()) {
          var progressController = Get.find<CoursepProgresscConteroller>();
          await progressController.loadWatchedVideos();
          await progressController.loadCourseProgress();
          await progressController.updateCourseProgress();
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

  enroll() async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog('m12'.tr);
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
      await getData();
      if (data['price'] == '0.00') {
        // Get.toNamed(AppRoutes.learningCourse, arguments: {
        //   'ID': idCourse,
        // });
        // Get.find<MyCoursesControllerIMP>().getMyCourses(idCourse!);
        // Get.find<MyCoursesControllerIMP>().refreshCourses();
        await getData();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.find<MainpagecontrollerIMP>().changePage(1);
        Get.offAllNamed(AppRoutes.mainPage);
      } else {
        print(
            'toooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
        Get.find<MainpagecontrollerIMP>().changePage(1);
        Get.offAllNamed(AppRoutes.mainPage);
      }
    } else {
      showCustomSnackbar(
        title: "Registration failed",
        message: "Please try again.",
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
    showLoadingDialog('Canceling subscription');
    var response = await courseUnEnroll.getData("$idCourse");
    print(response);
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      showCustomSnackbar(
        title: "Registration has been successfully canceled ",
        message: "We hope you have benefited from the course",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );
      checkEnrollment();
      Get.back();
      Get.find<MainpagecontrollerIMP>().changePage(1);
      Get.offAllNamed(AppRoutes.mainPage);
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      print("Failed to fetch course data");
      showCustomSnackbar(
        title: "cancellation of registration failed",
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
    print('✅checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
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

  addNote([int? videoID]) async {
    if (formstate.currentState!.validate()) {
      statusrequest = Statusrequest.loading;
      showLoadingDialog('adding the note..');
      update();
      var noteTitleText =
          noteTitle.text.trim().isEmpty ? null : noteTitle.text.trim();
      var response = await addNotesData.getData(
          idCourse!, content.text, videoID, noteTitleText);

      statusrequest = handilingData(response);
      update();
      if (Statusrequest.success == statusrequest) {
        allNotes.clear();
        await getAllNotes(idCourse);
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
    noteTitle.clear();
  }

  Future<void> getAllVideoNotes(int idCourse, int idvideo) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await viewVideoNotesData.getData(idCourse, idvideo);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      allVideoNotes.clear();

      if (response is Map && response['data'] is List) {
        allVideoNotes.addAll(response['data']);
      }

      print("✅ success to get video notes");
    } else {
      print("❌ Failed to get video notes: $response");
      statusrequest = Statusrequest.failure;
    }
    update();
  }

  deleteNote(int noteId) async {
    statusrequest = Statusrequest.loading;
    showLoadingDialog('seleting the note..');
    update();
    var response = await deleteNotesData.getData(noteId);
    statusrequest = handilingData(response);
    update();
    if (Statusrequest.success == statusrequest) {
      allNotes.clear();
      await getAllNotes(idCourse);
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

  ViewProgress viewProgress = ViewProgress(crud: Get.find<Crud>());
  CheckQuizAttemptData checkQuizAttemptData =
      CheckQuizAttemptData(crud: Get.find<Crud>());
  GetQuizzesData getQuizData = GetQuizzesData();

  bool canTakeQuiz = false;

  int progress = 0;
  Map quizData = {};

  void getQuizesData() async {
    statusrequest = Statusrequest.loading;
    update();
    try {
      final response = await viewProgress.getData(idCourse!);
      final responsequiz = await getQuizData.getData(idCourse!);

      statusrequest = handilingData(response);

      if (statusrequest == Statusrequest.success) {
        quizData.clear();

        // التعامل مع استجابة الكويز
        if (responsequiz is Map && responsequiz.containsKey('error')) {
          // حالة 403 أو عدم السماح بفتح الكويز
          canTakeQuiz = false;
          progress = responsequiz['progress'] ?? 0;
          quizData = {};
          print("⚠️ Cannot take quiz: ${responsequiz['error']}");
        } else if (responsequiz is List && responsequiz.isNotEmpty) {
          quizData = responsequiz[0];
        } else if (responsequiz is Map) {
          quizData = responsequiz;
        } else {
          quizData = {};
          print("❌ Unexpected quiz data format: $responsequiz");
        }

        // تحديث التقدم
        progress = response['progress'] ?? 0;

        // تحديد القدرة على فتح الكويز
        int isSequential = data['is_sequential'] ?? 0;
        int requiredProgress = isSequential == 1 ? 100 : 80;
        canTakeQuiz = progress >= requiredProgress;

        // استدعاء التحقق من المحاولة فقط إذا الكويز موجود
        if (quizData.containsKey('id') && quizData['id'] != null) {
          CheckQuizAttempt();
        } else {
          print("⚠️ quizData does not contain a valid ID.");
        }

        print('✅ Loaded quiz data successfully');
      } else {
        print("❌ Failed to load quiz data");
      }
    } catch (e) {
      print("❌ Error fetching quiz data: $e");
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  bool hasAttempt = false;

  void CheckQuizAttempt() async {
    statusrequest = Statusrequest.loading;
    update();
    final response =
        await checkQuizAttemptData.getData(idCourse!, quizData['id']);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      checkdata.clear();
      checkdata = response;
      hasAttempt = response['has_attempted'];
      print('✅ success to check  quiz');
    } else {
      print("❌ Failed to load check quiz");
    }

    update();
  }

  getMyCourses(user) {}
}
