import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class LoginData {
  Crud? crud;
  LoginData({this.crud});
  getData(String email, String password) async {
    var response = await crud!.postRequest(Applinks.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
