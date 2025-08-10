import 'dart:io';

import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/mycourses/quiz.dart';

class ResultsController extends GetxController {
  CourseControllerIMP courseController = Get.find();

  GetQuizResultsData getQuizResults =
      GetQuizResultsData(crud: Get.find<Crud>());
  GetCertificateData getCertificateData =
      GetCertificateData(crud: Get.find<Crud>());

  CheckQuizAttemptData checkQuizAttemptData =
      CheckQuizAttemptData(crud: Get.find<Crud>());
  GetQuizzesData getQuizData = GetQuizzesData();
  late int idCourse;
  late int idquiz;
  late String url;
  late Statusrequest statusrequest;
  Map<String, dynamic> resultsdata = {};
  late int attemptId;
  @override
  void onInit() {
    getResults();
    getCertificate();
    quizdata = courseController.quizData;
    super.onInit();
  }

  late Map quizdata;
  getResults() async {
    statusrequest = Statusrequest.loading;
    update();

    idCourse = courseController.idCourse!;
    idquiz = courseController.quizData['id']!;

    final responsecheck = await checkQuizAttemptData.getData(idCourse, idquiz);
    statusrequest = handilingData(responsecheck);

    if (statusrequest == Statusrequest.success) {
      final latestAttempt = responsecheck['latest_attempt'];

      if (latestAttempt != null && latestAttempt['id'] != null) {
        attemptId = latestAttempt['id'];
        var response = await getQuizResults.getData(attemptId);
        statusrequest = handilingData(response);

        if (statusrequest == Statusrequest.success) {
          if (response is Map<String, dynamic>) {
            resultsdata = response;
            print('✅ Get Quiz Results ');
          } else {
            print("❌ Unexpected results format: $response");
          }
        } else {
          print("❌ Failed to get QuizResults from getQuizResults.getData");
        }
      } else {
        print("❌ No attempt found");
      }
    } else {
      print("❌ Failed to check attempt");
    }

    update();
  }

  getCertificate() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await getCertificateData.getData(idCourse, idquiz);
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      url = response['certificateUrl'];
      print('✅success to get Certificate');
    } else {
      print('❌ field to get Certificate');
    }

    update();
  }
  // getCertificate() async {
  //   statusrequest = Statusrequest.loading;
  //   update();
  //   var response = await getCertificateData.getData(idCourse, idquiz);
  //   statusrequest = handilingData(response);
  //   if (statusrequest == Statusrequest.success) {
  //     if (response['message'] == 'Certificate already issued') {
  //       url = response['certificateUrl'];
  //       print('✅success to get Certificate');
  //     } else {
  //       url = response['data']['certificateUrl'];
  //       print('✅success to get Certificate');
  //     }
  //   } else {
  //     print('❌ field to get Certificate');
  //   }

  //   update();
  // }
}
