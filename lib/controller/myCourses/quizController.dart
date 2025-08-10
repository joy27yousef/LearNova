import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/myCourses/resultsController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/mycourses/quiz.dart';

class QuizController extends GetxController {
  late BuildContext context;

  final PageController pageController = PageController();
  RxBool isSubmitted = false.obs;
  GetQuizzesData getQuizData = GetQuizzesData();
  SubmitQuizData submitQuiz = SubmitQuizData(crud: Get.find<Crud>());
  GetQuizResultsData getQuizResults =
      GetQuizResultsData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;

  Map quizData = {};
  RxList questions = [].obs;
  RxMap<int, int> selectedAnswers = <int, int>{}.obs;
  RxInt currentPage = 0.obs;
  RxBool isLoading = true.obs;
  int? courseId;
  int? attemptId;
  RxInt timeLeftSeconds = 0.obs;
  Timer? timer;
  Map<String, dynamic> resultsdata = {};

  @override
  void onInit() {
    courseId = Get.arguments['id'];
    super.onInit();
  }

  void initController(BuildContext ctx) {
    context = ctx;
    loadQuizData();
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  Future<void> getQuizesData() async {
    statusrequest = Statusrequest.loading;
    update();
    final response = await getQuizData.getData(courseId!);
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      try {
        if (response is List && response.isNotEmpty) {
          quizData = response[0];
        } else if (response is Map) {
          quizData = response;
        } else {
          print("❌ Unexpected quiz data format: $response");
          quizData = {};
        }
        print('✅ Loaded quiz data successfully');
      } catch (e) {
        print("❌ Error parsing quiz data: $e");
        statusrequest = Statusrequest.failure;
      }
    } else {
      print("❌ Failed to load quiz data");
    }

    update();
  }

  Future<void> loadQuizData() async {
    await getQuizesData();
    questions.value = quizData["questions"] ?? [];
    int timeLimitMinutes = quizData["time_limit"] ?? 1;
    timeLeftSeconds.value = timeLimitMinutes * 60;
    startTimer();
    isLoading.value = false;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeftSeconds.value > 0) {
        timeLeftSeconds.value--;
      } else {
        timer.cancel();
        submitAnswers();
      }
    });
  }

  String formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  void selectAnswer(int questionIndex, int selectedOptionId) {
    selectedAnswers[questionIndex] = selectedOptionId;
  }

  void nextQuestion() {
    if (currentPage.value < questions.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // else {
    //   submitAnswers();
    // }
  }

  submitAnswers() async {
    if (isSubmitted.value) return; // 🔒 منع التكرار
    isSubmitted.value = true;

    timer?.cancel();
    showLoadingDialog(context, 'Transmitting..');
    statusrequest = Statusrequest.loading;
    update();
    Map<String, int> convertedAnswers = {};
    selectedAnswers.forEach((questionIndex, optionId) {
      if (questions.length > questionIndex) {
        final questionId = questions[questionIndex]['id'];
        if (questionId != null) {
          convertedAnswers[questionId.toString()] = optionId;
        }
      }
    });

    var response = await submitQuiz.getData(
      courseId!,
      quizData['id'],
      convertedAnswers,
    );

    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      attemptId = response['attemptId'];
      await getResults();
      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
      Get.put(MyCoursesControllerIMP());
      Get.offAndToNamed(AppRoutes.learningCourse, arguments: {
        "tabIndex": 1,
        'ID': courseId,
      });
      Get.put(MyCoursesControllerIMP());
      showCustomSnackbar(
        title: "Congratulations",
        message: "Your quiz has been submitted.",
        icon: Icons.celebration_rounded,
        backgroundColor: Appcolor.base,
      );
      print('✅ quiz submitted ');
    } else {
      if (Get.isDialogOpen ?? false) Get.back();
      showCustomSnackbar(
        title: "فشل",
        message: "فشل في إرسال الكويز. حاول مرة أخرى.",
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
      print("❌ Failed to submit course");
    }

    update();
  }

  getResults() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await getQuizResults.getData(attemptId!);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      // ✅ تأكيد أن الاستجابة Map
      if (response is Map<String, dynamic>) {
        resultsdata = response;

        print('✅ Get Quiz Results ');
      } else {
        print("❌ Unexpected results format: $response");
      }
    } else {
      print("❌ Failed to get QuizResults");
    }

    update();
  }
}
