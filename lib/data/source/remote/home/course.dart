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
