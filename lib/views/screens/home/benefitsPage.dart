import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/views/widgets/homePage/benefitsGen.dart';

class BenefitsPage extends StatelessWidget {
  const BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Why Choose LearNova',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
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
