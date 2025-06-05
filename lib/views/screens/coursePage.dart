import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Name of The course',
            style: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.Poppins,
                fontWeight: FontWeight.bold)),
        backgroundColor: Appcolor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}
