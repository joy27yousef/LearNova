import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/settingController.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/profile/ListofChangeMode.dart';
import 'package:learn_nova/views/widgets/profile/listof.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingControllerIMP controller = Get.put(SettingControllerIMP());

    return Scaffold(
      appBar: AppBar(
        title: Text('54'.tr),
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  '54'.tr,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 10),
              Listof(
                lan: true,
                title: '59'.tr,
                icon1: Iconsax.language_circle5,
                languageApp:
                    Get.locale!.languageCode == 'ar' ? "العربية" : "English",
                onTap: () {
                  controller.showLanguageOptions(Get.context!);
                },
              ),
              const SizedBox(height: 5),
              Listofchangemode(
                title: '60'.tr,
                icon1: Icons.nights_stay_outlined,
                icon2: Icons.navigate_next_rounded,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  '61'.tr,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 10),
              Listof(
                title: '62'.tr,
                icon1: Iconsax.edit,
                icon2: Icons.navigate_next_rounded,
                onTap: () {
                  Get.toNamed(AppRoutes.editProfile);
                },
              ),
              const SizedBox(height: 5),
              Listof(
                title: '63'.tr,
                icon1: Iconsax.logout,
                icon2: Icons.navigate_next_rounded,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
