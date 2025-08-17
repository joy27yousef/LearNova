import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

class Footertext extends StatelessWidget {
  final String text1;
  final String text2;
  final String i;
  const Footertext(
      {super.key, required this.text1, required this.text2, required this.i});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text1,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w300)),
        InkWell(
          onTap: () {
            Get.offNamed((i == 'login') ? AppRoutes.signup : AppRoutes.login);
          },
          child: Text(text2,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Appcolor.base,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: Appcolor.base,
                  decorationThickness: 1.5)),
        )
      ],
    );
  }
}
