import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/controller/auth/forgotPassController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Forgotpassword extends StatelessWidget {
  final String page;
  const Forgotpassword({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    // ForgotpassControllerIMP controller = Get.put(ForgotpassControllerIMP());
    ForgotpassControllerIMP controller = Get.put(ForgotpassControllerIMP());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '30'.tr,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => alerExitApp(context),
        child: Form(
          key: controller.formstate,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
            child: Column(
              children: [
                Flexible(
                    flex: 3,
                    child: Image.asset(
                      Get.find<ThemeController>().isDarkMode.value
                          ? Appimages.forgotpassworddark
                          : Appimages.forgotpassword,
                    )),
                Flexible(
                    flex: 3,
                    child: ListView(
                      children: [
                        Text(
                          '31'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 17),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextformAuth(
                          valid: (val) {
                            return validInput(val!, 5, 100, 'email');
                          },
                          hint: '14'.tr,
                          lable: '15'.tr,
                          iconform: Icon(
                            Icons.email_outlined,
                            color: Appcolor.baselight2,
                          ),
                          mycontroller: controller.email,
                          typekey: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Boxtext(
                          textin: '32'.tr,
                          onTapFun: () {
                            controller.sendEmailOTP(context, page);
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
