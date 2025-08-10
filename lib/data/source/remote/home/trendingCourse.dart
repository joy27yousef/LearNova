import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class TrendingCourseData {
  Crud? crud;
  TrendingCourseData({this.crud});
  getData() async {
    var response = await crud!.getRequest(Applinks.trending);
    return response.fold((l) => l, (r) => r);
  }
}
