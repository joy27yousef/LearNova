import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/auth/signupController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/auth/circle.dart';
import 'package:learn_nova/views/widgets/auth/conditionsAgree.dart';
import 'package:learn_nova/views/widgets/auth/footerText.dart';
import 'package:learn_nova/views/widgets/auth/googleLogin.dart';
import 'package:learn_nova/views/widgets/auth/orLoginWith.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';
import 'package:learn_nova/views/widgets/auth/textinLogSingin.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Signup extends StatelessWidget {
  final SignupControllerIMP controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () => alerExitApp(context),
      child: Form(
        key: controller.formstate,
        child: Stack(
          children: [
            Circle(),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Textinlogsingin(text1: '21'.tr, text2: '22'.tr),
                    SizedBox(
                      height: 35,
                    ),
                    TextformAuth(
                      valid: (val) {
                        return validInput(val!, 3, 100, 'username');
                      },
                      hint: 'Enter your first name',
                      lable: 'first name',
                      iconform: Icon(
                        Icons.person_2_rounded,
                        color: Appcolor.baselight2,
                      ),
                      mycontroller: controller.firstName,
                      typekey: TextInputType.name,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextformAuth(
                      valid: (val) {
                        return validInput(val!, 3, 100, 'username');
                      },
                      hint: 'Enter your last name',
                      lable: 'last name',
                      iconform: Icon(
                        Icons.person_2_rounded,
                        color: Appcolor.baselight2,
                      ),
                      mycontroller: controller.lastName,
                      typekey: TextInputType.name,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextformAuth(
                      valid: (val) {
                        return validInput(val!, 3, 10, 'phone');
                      },
                      hint: 'Enter your phone number',
                      lable: 'phone',
                      iconform: Icon(
                        Icons.phone_android_rounded,
                        color: Appcolor.baselight2,
                      ),
                      mycontroller: controller.phoneNumber,
                      typekey: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 15,
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
                      height: 15,
                    ),
                    GetBuilder<SignupControllerIMP>(
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
                          controller.isShowPassword
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
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
                    GetBuilder<SignupControllerIMP>(
                      builder: (controller) => TextformAuth(
                        obscureText: controller.isShowPassword,
                        onTapicon: () {
                          controller.showPassword();
                        },
                        valid: (val) => validInput(
                          val ?? "",
                          6,
                          30,
                          "confirmPassword",
                          compareWith: controller.password.text,
                        ),
                        hint: '25'.tr,
                        lable: '26'.tr,
                        iconform: Icon(
                          controller.isShowPassword
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                          color: Appcolor.baselight2,
                        ),
                        mycontroller: controller.confirmPassword,
                        typekey: TextInputType.name,

                        // isnumber: isnumber
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Conditionsagree(),
                    SizedBox(
                      height: 30,
                    ),
                    Boxtext(
                      textin: '27'.tr,
                      onTapFun: () {
                        controller.Register(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Orloginwith(textin: '27'.tr),
                    SizedBox(
                      height: 20,
                    ),
                    Googlelogin(),
                    SizedBox(
                      height: 40,
                    ),
                    Footertext(
                      text1: '28'.tr,
                      text2: '29'.tr,
                      i: "signin",
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
