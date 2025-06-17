import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserController extends GetxController {}

class UserControllerIMP extends UserController {
  static const _key = 'profile_image_path';

  RxString profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileImagePath();
  }

  Future<void> loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_key) ?? '';
    if (path.isNotEmpty && File(path).existsSync()) {
      profileImagePath.value = path;
    }
    
  }

  Future<void> updateProfileImage(String newPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newPath);
    profileImagePath.value = newPath;
  }

  Future<void> clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    profileImagePath.value = '';
  }
}
