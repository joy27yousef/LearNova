import 'package:get/utils.dart';

String translationData() {
  if (Get.locale!.languageCode == 'en') {
    return 'en';
  } else {
    return "ar";
  }
}
