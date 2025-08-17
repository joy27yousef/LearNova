import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/controller/auth/verificationController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Checkemail extends StatelessWidget {
  Checkemail({super.key});
  final VerificationControllerIMP controller =
      Get.put(VerificationControllerIMP());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () => alerExitApp(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    Get.find<ThemeController>().isDarkMode.value
                        ? Appimages.verificationDark
                        : Appimages.verification,
                    height: 250),
                const SizedBox(height: 30),
                Text(
                  "Check your email",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Please enter the 6-digit code sent to your email.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                OtpTextField(
                    borderRadius: BorderRadius.circular(20),
                    numberOfFields: 6,
                    borderColor: Appcolor.base,
                    focusedBorderColor: Appcolor.base,
                    showFieldAsBox: true,
                    fieldWidth: 40,
                    onSubmit: (xx) {
                      controller.code = xx;
                    }),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Boxtext(
                    textin: 'check',
                    onTapFun: () {
                      if (controller.code.isEmpty) {
                        Get.defaultDialog(
                            title: "Warning",
                            middleText: "Please enter the verification code.");
                      } else {
                        controller.chechCode(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
