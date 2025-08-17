import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';

class RatingPage extends StatelessWidget {
  RatingPage({super.key});
  final RatingController controller = Get.put(RatingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RatingController>(builder: (controller) {
        return Handilingdataview(
            statusrequests: [controller.statusrequest], widget: SizedBox());
      }),
    );
  }
}
