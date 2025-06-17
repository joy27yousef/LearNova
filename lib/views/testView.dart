import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/testController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';

class Testview extends StatelessWidget {
  const Testview({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Testcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Test View'),
      ),
      body: GetBuilder<Testcontroller>(builder: (controller) {
        return Handilingdataview(
          statusrequest: controller.statusrequest,
          widget: ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                return Text('${controller.data}');
              }),
        );
      }),
    );
  }
}
