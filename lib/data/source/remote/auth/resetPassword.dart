import 'package:dartz/dartz.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class Resetpassword_Email {
  Crud? crud;
  Resetpassword_Email({this.crud});
  Future<Either<Statusrequest, Map>> getData(String email) async {
    var response = await crud!.postRequest(Applinks.resetPassEmail, {
      "email": email,
    });
    return response;
  }
}

class Resetpassword {
  Crud? crud;
  Resetpassword({this.crud});
  Future<Either<Statusrequest, Map>> getData(
      int id, String otp, String password, String confirmationPass,) async {
        
    var response = await crud!.postRequest(Applinks.resetPass, {
      
      "user_id": id,
      "otp": otp,
      "password": password,
      "password_confirmation": confirmationPass
    });
    return response;
  }
}
