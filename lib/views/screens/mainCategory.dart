import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/categoryController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class MainCategory extends StatelessWidget {
  final controller = Get.put(CategoryControllerIMP());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Appcolor.backgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Appcolor.backgroundColor,
        //   title: Text(
        //     'Why Choose LearNova',
        //     style: TextStyle(
        //       fontFamily: AppFonts.Poppins,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios_new_rounded),
        //     onPressed: () => Get.back(),
        //   ),
        // ),
        // body: Column(
        //   children: [
        //     Obx(() {
        //       return Container(
        //         height: 60,
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: controller.subcategories.length,
        //           itemBuilder: (context, i) {
        //             bool isSelected = controller.selectedIndex.value == i;
        //             return GestureDetector(
        //               onTap: () => controller.changeTab(i),
        //               child: Container(
        //                 margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //                 padding: EdgeInsets.symmetric(horizontal: 16),
        //                 decoration: BoxDecoration(
        //                   color: isSelected ? Appcolor.base : Colors.grey[100],
        //                   borderRadius: BorderRadius.circular(30),
        //                 ),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     Text(
        //                       controller.subcategories[i],
        //                       style: TextStyle(
        //                         fontFamily: AppFonts.Poppins,
        //                         color: isSelected ? Colors.white : Colors.black87,
        //                         fontSize: isSelected ? 16 : 14,
        //                         fontWeight: isSelected
        //                             ? FontWeight.bold
        //                             : FontWeight.normal,
        //                       ),
        //                     ),
        //                     if (isSelected)
        //                       Container(
        //                         margin: EdgeInsets.only(top: 4),
        //                         height: 3,
        //                         width: 24,
        //                         decoration: BoxDecoration(
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(10),
        //                         ),
        //                       ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       );
        //     }),
        //     Expanded(
        //       child: Obx(() {
        //         final index = controller.selectedIndex.value;
        //         final name = controller.subcategories[index];
        //         return Container(
        //           alignment: Alignment.center,
        //           margin: EdgeInsets.all(16),
        //           padding: EdgeInsets.all(24),
        //           decoration: BoxDecoration(
        //             color: Colors.blue.withOpacity(0.1 * (index + 1)),
        //             borderRadius: BorderRadius.circular(16),
        //           ),
        //           child: Text(
        //             'محتوى $name',
        //             style: TextStyle(fontSize: 24),
        //           ),
        //         );
        //       }),
        //     ),
        //   ],
        // ),
        );
  }
}
