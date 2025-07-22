import 'package:get/get.dart';

String? validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "v1".tr;
  }

  if (val.length < min) {
    return "v2".tr + ' $min';
  }

  if (val.length > max) {
    return "v4".tr + " $max";
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "v5".tr;
    }
  }

  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "v6".tr;
    }
  }

  if (type == "password") {
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(val)) {
      return 'v7'.tr;
    }
  }

  return null;
}
