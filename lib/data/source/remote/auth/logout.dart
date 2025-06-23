import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class LogoutData {
  Crud? crud;
  LogoutData({this.crud});
  getData() async {
    var response = await crud!.deleteRequest(
      Applinks.logout,
    );
    return response.fold((l) => l, (r) => Statusrequest.success);
  }
}
