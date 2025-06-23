import 'package:dartz/dartz.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class VerificationData {
  Crud? crud;
  VerificationData({this.crud});
  Future<Either<Statusrequest, Map>> getData(int id, String code) async {
    var response = await crud!.postRequest(Applinks.verify, {
      "user_id": id,
      "otp": code,
    });
    return response;
  }
}
