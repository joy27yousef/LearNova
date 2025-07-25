import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/alertExitApp.dart';

class OnboardingAuth extends StatelessWidget {
  const OnboardingAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundLight,
      body: WillPopScope(
        onWillPop: () => alerExitApp(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Appimages.logo),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Let’s you in',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 20,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoutes.signup);
                    },
                    child: Text(
                      ' LearNova',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color.fromARGB(255, 105, 53, 190),
                            fontSize: 25,
                          ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoutes.login);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Appcolor.baselight,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: const Color.fromARGB(255, 105, 53, 190),
                  ),
                  child: Center(
                    child: Text(
                      "18".tr + ' with your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppFonts.Poppins,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Don’t have an Account?',
                      style: Theme.of(context).textTheme.titleMedium),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoutes.signup);
                    },
                    child: Text(
                      ' SIGN UP',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: const Color.fromARGB(255, 105, 53, 190),
                            fontSize: 17,
                          ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
