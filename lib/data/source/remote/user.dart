import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class UserData {
  Crud? crud;
  UserData({this.crud});
  getData() async {
    var response = await crud!.getRequest(Applinks.user, withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}
