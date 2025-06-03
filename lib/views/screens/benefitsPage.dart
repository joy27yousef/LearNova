import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/views/widgets/homePage/benefitsGen.dart';

class BenefitsPage extends StatelessWidget {
  const BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        title: Text('Why Choose LearNova',
            style: TextStyle(
                fontFamily: AppFonts.Poppins, fontWeight: FontWeight.bold)),
        backgroundColor: Appcolor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Benefitsgen(
        x: Benefits.length,
        y: 20,
      ),
    );
  }
}
