import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        title: Text(
          'Search in LearNova',
          style: TextStyle(
              fontFamily: AppFonts.Poppins, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
