import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class CourseData {
  Crud? crud;
  CourseData({this.crud});
  getData(String courseID) async {
    var response =
        await crud!.getRequest("${Applinks.externalCourses}/$courseID");
    return response.fold((l) => l, (r) => r);
  }
}

class CourseEnrollData {
  Crud? crud;
  CourseEnrollData({this.crud});
  getData(String courseID) async {
    var response = await crud!.postRequest(
      "${Applinks.courseEnroll}/$courseID/enroll",
      {},
      withToken: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}

class CourseUnEnrollData {
  Crud? crud;
  CourseUnEnrollData({this.crud});
  getData(String courseID) async {
    var response = await crud!
        .deleteRequest("${Applinks.courseEnroll}/$courseID/unenroll");
    return response.fold((l) => l, (r) => r);
  }
}

class UserEnrollmentsData {
  Crud? crud;
  UserEnrollmentsData({this.crud});
  getData(int userId) async {
    var response = await crud!.getRequest(
        "${Applinks.userCourseEnrollment}/$userId/enrollments",
        withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class PaymentStatusData {
  Crud? crud;
  PaymentStatusData({this.crud});
  getData(int courseid) async {
    var response = await crud!.getRequest(
        "${Applinks.progress}/$courseid/payment-status",
        withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}
