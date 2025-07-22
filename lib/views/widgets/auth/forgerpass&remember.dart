import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
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
          child: Text('30'.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Appcolor.base,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
        ),
      ],
    );
  }
}
