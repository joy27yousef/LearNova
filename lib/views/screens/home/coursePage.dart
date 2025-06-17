import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Course Overview',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Image.asset('assets/images/testpop1.jpg'),
            Text(
              "UX/UI Design",
              style: TextStyle(
                  fontFamily: AppFonts.Poppins,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
