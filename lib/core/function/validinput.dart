import 'package:get/get.dart';

String? validInput(String val, int min, int max, String type,
    {String? compareWith}) {
  if (val.isEmpty) {
    return "v1".tr; // الحقل فارغ
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

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "phone";
    }
  }

  if (type == "confirmPassword") {
    if (compareWith != null && val != compareWith) {
      return "Passwords do not match".tr;
    }
  }

  return null;
}
