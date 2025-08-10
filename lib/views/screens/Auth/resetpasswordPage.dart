import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/auth/resetPasController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    // ResetpascontrollerIMP controller = Get.put(ResetpascontrollerIMP());
    ResetpascontrollerIMP controller = Get.put(ResetpascontrollerIMP());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '33'.tr,
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
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      Appimages.resetpassword,
                      width: 300,
                    )),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                    flex: 2,
                    child: ListView(
                      children: [
                        Text(
                          "Please enter the 6-digit code sent to your email.",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        OtpTextField(
                            borderRadius: BorderRadius.circular(20),
                            numberOfFields: 6,
                            borderColor: Appcolor.base,
                            focusedBorderColor: Appcolor.base,
                            showFieldAsBox: true,
                            fieldWidth: 40,
                            onSubmit: (code) {
                              controller.code = code;
                            }),
                        const SizedBox(height: 20),
                        Text(
                          '34'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<ResetpascontrollerIMP>(
                          builder: (controller) => TextformAuth(
                            obscureText: controller.isShowPassword,
                            onTapicon: () {
                              controller.showPassword();
                            },
                            valid: (val) {
                              return validInput(val!, 8, 100, 'password');
                            },
                            hint: '16'.tr,
                            lable: '17'.tr,
                            iconform: Icon(
                              Icons.lock_outline_rounded,
                              color: Appcolor.baselight2,
                            ),
                            mycontroller: controller.password,
                            typekey: TextInputType.name,

                            // isnumber: isnumber
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<ResetpascontrollerIMP>(
                          builder: (controller) => TextformAuth(
                            obscureText: controller.isShowPassword,
                            onTapicon: () {
                              controller.showPassword();
                            },
                            valid: (val) {
                              return validInput(val!, 8, 100, 'password');
                            },
                            hint: '25'.tr,
                            lable: '26'.tr,
                            iconform: Icon(
                              Icons.lock_outline_rounded,
                              color: Appcolor.baselight2,
                            ),
                            mycontroller: controller.confirmPassword,
                            typekey: TextInputType.name,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Boxtext(
                          textin: '33'.tr,
                          onTapFun: () {
                            controller.savePass(context);
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
