import 'package:get/get.dart';

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return '36'.tr;
  } else if (hour >= 12 && hour < 17) {
    return '37'.tr;
  } else if (hour >= 17 && hour < 21) {
    return '38'.tr;
  } else {
    return '39'.tr;
  }
}
