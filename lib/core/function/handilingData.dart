import 'package:learn_nova/core/class/statusRequest.dart';

handilingData(response) {
  if (response is Statusrequest) {
    return response;
  } else {
    return Statusrequest.success;
  }
}
