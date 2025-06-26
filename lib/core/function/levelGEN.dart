import 'package:get/get.dart';

String levelGen(String x) {
  if (x == 'beginner') {
    return '89'.tr;
  } else if (x == 'intermediate') {
    return '90'.tr;
  } else {
    return '91'.tr;
  }
}
