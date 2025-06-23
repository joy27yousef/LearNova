import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:learn_nova/controller/auth/loginController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/auth/circle.dart';
import 'package:learn_nova/views/widgets/auth/footerText.dart';
import 'package:learn_nova/views/widgets/auth/forgerpass&remember.dart';
import 'package:learn_nova/views/widgets/auth/googleLogin.dart';
import 'package:learn_nova/views/widgets/auth/orLoginWith.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';
import 'package:learn_nova/views/widgets/auth/textinLogSingin.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.backgroundLight,
        body: WillPopScope(
          onWillPop: alerExitApp,
          child: Form(
            key: controller.formstate,
            child: Stack(
              children: [
                Circle(),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Textinlogsingin(
                            text1:'12'.tr ,
                            text2: '13'.tr),
                        SizedBox(
                          height: 35,
                        ),
                        TextformAuth(
                          hint: '14'.tr,
                          lable: '15'.tr,
                          iconform: Icon(
                            Icons.email_outlined,
                            color: Appcolor.baselight2,
                          ),
                          mycontroller: controller.email,
                          typekey: TextInputType.emailAddress,
                          valid: (val) {
                            return validInput(val!, 5, 100, 'email');
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GetBuilder<LoginControllerImp>(
                          builder: (controller) => TextformAuth(
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
                              obscureText: controller.isShowPassword,
                              onTapicon: () {
                                controller.showPassword();
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Forgerpasstext(),
                        SizedBox(
                          height: 40,
                        ),
                        Boxtext(
                          textin: '18'.tr,
                          onTapFun: () {
                            controller.login(context);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Orloginwith(textin: '18'.tr),
                        SizedBox(
                          height: 20,
                        ),
                        Googlelogin(),
                        SizedBox(
                          height: 40,
                        ),
                        Footertext(
                          text1: '19'.tr,
                          text2: '20'.tr,
                          i: "login",
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
