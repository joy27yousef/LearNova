import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/mycourses/progressCourse.dart';
import 'package:learn_nova/data/source/remote/mycourses/quiz.dart';

class QuizController extends GetxController {
  late Statusrequest statusrequest;
  CourseControllerIMP courseDataController = Get.find();
  ViewProgress viewProgress = ViewProgress(crud: Get.find<Crud>());
  GetQuizData getQuizData = GetQuizData(crud: Get.find<Crud>());
  late bool canTakeQuiz;
  late int progress;
  List quizData = [];

  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> canGetQuiz() async {
    int courseId = courseDataController.data['id'];
    var response = await viewProgress.getData(courseId);
    var responsedata = await getQuizData.getData(courseId);
    statusrequest = handilingData(response);
    update();
    if (statusrequest == Statusrequest.success) {
      quizData.clear();
      quizData.add(responsedata['quiz']);
      print('✌️ sucsess to load quiz');
      print(responsedata);
      canTakeQuiz = response['canTakeQuiz'];
      progress = response['progress'];
      return response['canTakeQuiz'];
    } else {
      print("❌ Failed to submit rating");
      return response['canTakeQuiz'];
    }
  }

}
