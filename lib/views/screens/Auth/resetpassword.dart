import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/auth/resetPasController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/auth/textformAuth.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class Resetpassword extends StatelessWidget {
  const Resetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    ResetpascontrollerIMP controller = Get.put(ResetpascontrollerIMP());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Appcolor.backgroundLight,
        title: Text(
          '33'.tr,
          style: TextStyle(
              fontSize: 18,
              fontFamily: AppFonts.Poppins,
              fontWeight: FontWeight.w400),
        ),
      ),
      backgroundColor: Appcolor.backgroundLight,
      body: Form(
        key: controller.formstate,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Image.asset(
                    Appimages.resetpassword,
                    width: 300,
                  )),
              SizedBox(
                height: 30,
              ),
              Expanded(
                  flex: 3,
                  child: ListView(
                    children: [
                      Text(
                        '34'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontFamily: AppFonts.Poppins,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 50,
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
                          mycontroller: controller.password,
                          typekey: TextInputType.name,

                          // isnumber: isnumber
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Boxtext(
                        textin: '33'.tr,
                        onTapFun: () {
                          controller.savePass();
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
