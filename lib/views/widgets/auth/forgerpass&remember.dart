import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

class Forgerpasstext extends StatelessWidget {
  const Forgerpasstext({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.forgotPassword);
          },
          child: const Text(
            'Forgot Password ?',
            style: TextStyle(
              color: Appcolor.base,
              fontSize: 15,
              fontFamily: AppFonts.Poppins,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
