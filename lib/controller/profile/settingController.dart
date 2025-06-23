import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/data/source/remote/auth/logout.dart';
import '../../core/constant/AppRoutes.dart';
import '../../core/localization/changeLocal.dart';

abstract class SettingController extends GetxController {}

class SettingControllerIMP extends SettingController {
  late Statusrequest statusrequest;
  localController controllerLang = Get.put(localController());

  logout() async {
    LogoutData logoutData = LogoutData(crud: Get.find<Crud>());
    var status = await logoutData.getData();
    if (status == Statusrequest.success) {
      await GetStorage().erase();
      Get.find<UserControllerIMP>().clearUserData();
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar("Sucssess", "Logout done", backgroundColor: Colors.pink[50]);
    } else {
      Get.snackbar("Error", "Logout failed");
    }
  }

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
