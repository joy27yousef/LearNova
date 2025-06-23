import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class SignupData {
  Crud ? crud;
  SignupData({this.crud});
  getData(String name, String email, String password,
      String password_confirmation) async {
    var response = await crud!.postRequest(Applinks.signup, {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
    });
    return response.fold((l) => l, (r) => r);
  }
}
