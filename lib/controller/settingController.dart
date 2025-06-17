import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

import '../core/localization/changeLocal.dart';

abstract class SettingController extends GetxController {}

class SettingControllerIMP extends SettingController {
  localController controllerLang = Get.put(localController());
  void showLanguageOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Appcolor.backgroundLight,
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.grey,
            ),
            title: Text(
              'English',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: AppFonts.Poppins,
              ),
            ),
            onTap: () {
              controllerLang.changelang('en');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.grey,
            ),
            title: Text(
              'Arabic',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: AppFonts.Poppins,
              ),
            ),
            onTap: () {
              controllerLang.changelang('ar');
            },
          ),
        ],
      ),
    );
  }
}
