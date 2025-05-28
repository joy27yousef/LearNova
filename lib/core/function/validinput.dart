
import 'package:get/get_utils/src/get_utils/get_utils.dart';

String? validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "can't be empty";
  }

  if (val.length < min) {
    return "value can't be less than $min";
  }

  if (val.length > max) {
    return "value can't be larger than $max";
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Invalid e-mail address";
    }
  }

  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "the username should contain only letters and numbers";
    }
  }

  if (type == "password") {
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(val)) {
      return 'The password must contain letters and numbers and not less than 8 digits';
    }
  }

  return null;
}
