import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class HelpCenterMessage {
  Crud? crud;
  HelpCenterMessage({this.crud});
  getData(String first, String last, String email, String phone, String subject,
      String message) async {
    var response = await crud!.postRequest(Applinks.helpCenter, {
      "first_name": first,
      "last_name": last,
      "email": email,
      "phone": phone,
      "subject": subject,
      "message": message
    });
    return response.fold((l) => l, (r) => r);
  }
}
