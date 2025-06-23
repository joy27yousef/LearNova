// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:learn_nova/controller/categoryController.dart';
// import 'package:learn_nova/core/class/handilingDataView.dart';
// import 'package:learn_nova/core/class/statusRequest.dart';

// class TestApp extends StatelessWidget {
//   const TestApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CategoryControllerIMP controller = Get.put(CategoryControllerIMP());

//     final box = GetStorage();
//     String? token = box.read('token');
//     controller.getData();
//     return Scaffold(
//       appBar: AppBar(title: Text("Test")),
//       body: GetBuilder<CategoryControllerIMP>(
//         builder: (controller) => Handilingdataview(
//             statusrequest: controller.statusrequest,
//             widget: ListView.builder(
//               itemCount: controller.maincategories.length,
//               itemBuilder: (context, i) => Container(
//                 height: 50,
//                 alignment: Alignment.centerLeft,
//                 child: Text(controller.maincategories[i]['name']
//                     ['en']), // عرض الاسم بالعربي
//               ),
//             )),
//       ),
//     );
//   }
// }
