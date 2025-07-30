import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class GetQuizData {
  Crud? crud;
  GetQuizData({this.crud});
  getData(int courseId) async {
    var response = await crud!.getRequest(
      "${Applinks.quiz}/$courseId/quiz/$courseId",
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}
