import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class ExternalCourseData {
  Crud? crud;
  ExternalCourseData({this.crud});
  getData() async {
    var response = await crud!.getRequest(Applinks.externalCourses);
    return response.fold((l) => l, (r) => r);
  }
}
