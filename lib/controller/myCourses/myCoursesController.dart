import 'package:get/get.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/home/course.dart';
import 'package:learn_nova/data/source/remote/mycourses/progressCourse.dart';

abstract class MyCoursesController extends GetxController {
  getMyCourses(int userID);
}

class MyCoursesControllerIMP extends MyCoursesController {
  late Statusrequest statusrequest;
  ViewProgress viewProgress = ViewProgress(crud: Get.find<Crud>());
  UserEnrollmentsData userEnrollmentsData =
      UserEnrollmentsData(crud: Get.find<Crud>());
  List data = [];
  late double progress;
  @override
  getMyCourses(int userID) async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await userEnrollmentsData.getData(userID);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      data.clear();
      data.addAll(response['data']);
      print('✅ Courses loaded:');
      print(data);
    } else {
      print("❌ Failed to fetch course data");
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration.zero, () async {
      var userController = Get.find<UserControllerIMP>();

      // انتظار تحميل بيانات المستخدم
      while (userController.user.isEmpty || userController.user['id'] == null) {
        print("Waiting for user data...");
        await Future.delayed(Duration(milliseconds: 100));
      }

      int uid = userController.user['id'];
      print("✅ Loaded userId after wait: $uid");
      if (uid != 0) {
        getMyCourses(uid);
      } else {
        print("❗️userId is 0");
      }
    });
  }

  Future<double> loadCourseProgress(int idcourse) async {
    var response = await viewProgress.getData(idcourse);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      return response['progress'] * 1.0; // تأكد إنه Double
    }

    update();
    return 0.0; // في حال فشل الطلب
  }

  void refreshCourses() async {
    statusrequest = Statusrequest.loading;
    update();
    data.clear();
    var response = await userEnrollmentsData
        .getData(Get.find<UserControllerIMP>().user['id']);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      data.addAll(response['data']);
      print("✅ success to refresh course data");
    } else {
      print("❌ Failed to refresh course data");
    }

    update(); // لتحديث الواجهة بعد التحديث
  }
}
