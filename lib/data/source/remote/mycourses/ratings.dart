import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class addRatingData {
  Crud? crud;
  addRatingData({this.crud});
  getData(int courseId, double rating, String review) async {
    var response = await crud!.postRequest(
        "${Applinks.rating}/$courseId/ratings",
        withToken: true,
        {"rating": rating, "review": review});
    return response.fold((l) => l, (r) => r);
  }
}

class GetMyRatingData {
  Crud? crud;
  GetMyRatingData({this.crud});

  Future<Either<Statusrequest, Map>> getData(
      int courseId, double rating, String review) async {
    var response = await crud!.getRequest(
      "${Applinks.rating}/$courseId/my-rating",
      withToken: true,
    );
    return response; // ⚠️ لا تعمل fold هنا
  }
}

class deleteRatingData {
  Crud? crud;
  deleteRatingData({this.crud});
  getData(int courseId, int ratingId) async {
    var response = await crud!
        .deleteRequest("${Applinks.rating}/$courseId/ratings/$ratingId");
    return response.fold((l) => l, (r) => r);
  }
}

class EditRatingData {
  Crud? crud;
  EditRatingData({this.crud});
  getData(int courseId, int ratingId, double rating, String review) async {
    var response = await crud!.putRequest(
        "${Applinks.rating}/$courseId/ratings/$ratingId",
        {"rating": rating, "review": review},
        withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}
