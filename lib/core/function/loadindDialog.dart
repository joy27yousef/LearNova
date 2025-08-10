import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog(BuildContext context, String text) {
  FocusScope.of(context).unfocus();
  FocusManager.instance.primaryFocus?.unfocus();

  Get.dialog(
    Center(
      child: Container(
        height: 320,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              softWrap: true,
              overflow: TextOverflow.clip,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            Lottie.asset(
              Appimages.loading2,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.3),
  );
}
