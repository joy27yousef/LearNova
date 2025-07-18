import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class addRating {
  Crud? crud;
  addRating({this.crud});
  getData(int courseId, double rating, String review) async {
    var response = await crud!.postRequest(
        "${Applinks.addRating}/$courseId/ratings",
        withToken: true,
        {"rating": rating, "review": review});
    return response.fold((l) => l, (r) => r);
  }
}

class deleteRating {
  Crud? crud;
  deleteRating({this.crud});
  getData(int courseId, int ratingId) async {
    var response = await crud!
        .deleteRequest("${Applinks.deleteRating}/$courseId/ratings/$ratingId");
    return response.fold((l) => l, (r) => r);
  }
}
