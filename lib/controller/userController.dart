import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserController extends GetxController {
  onInit();
}

class UserControllerIMP extends UserController {
  late Statusrequest statusrequest;

  static const _imageKey = 'profile_image_path';
  static const _nameKey = 'user_name';
  static const _emailKey = 'user_email';
  static const _IDKey = 'userID';

  RxString profileImagePath = ''.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxInt userId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    profileImagePath.value = prefs.getString(_imageKey) ?? '';
    userName.value = prefs.getString(_nameKey) ?? '';
    userEmail.value = prefs.getString(_emailKey) ?? '';
    userId.value = prefs.getInt(_IDKey) ?? 0;
  }

  Future<void> updateProfileImage(String newPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageKey, newPath);
    profileImagePath.value = newPath;
  }

  Future<void> setUserData({
    required String name,
    required String email,
    required int id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setInt(_IDKey, id);
    userName.value = name;
    userEmail.value = email;
    userId.value = id;
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_imageKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_IDKey);
    profileImagePath.value = '';
    userName.value = '';
    userEmail.value = '';
    userId.value = 0;
  }
}
