import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class SignupData {
  Crud crud;
  SignupData(this.crud);
  postData(String name, String pass, String email) async {
    var response = await crud.postRequest(Applinks.signup, {
      'user_name': name,
      'user_password': pass,
      'user_email': email,
    });

    return response.fold((l) => l, (r) => r);
  }
}
