import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EditprofileController extends GetxController {
  late TextEditingController name;
  late TextEditingController Email;
  void pickImage(ImageSource gallery) {}
}

class EditprofileControllerIMP extends EditprofileController {
  Rx<File?> imageFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  static const _imageKey = 'profile_image_path';

  @override
  void onInit() {
    name = TextEditingController();
    Email = TextEditingController();
    super.onInit();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imageKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      imageFile.value = File(imagePath);

      final userController = Get.find<UserControllerIMP>();
      userController.updateProfileImage(imagePath);
    }
  }

  Future<void> clearImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imageKey);

    if (imagePath != null) {
      final file = File(imagePath);
      if (file.existsSync()) {
        await file.delete();
      }

      final userController = Get.find<UserControllerIMP>();
      userController.clearUserData();
    }

    imageFile.value = null;
    await prefs.remove(_imageKey);
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage =
          await File(pickedFile.path).copy('${directory.path}/$fileName');

      imageFile.value = savedImage;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_imageKey, savedImage.path);

      final userController = Get.find<UserControllerIMP>();
      userController.updateProfileImage(savedImage.path);
    }
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: Icon(
              Icons.photo_library,
              color: Colors.grey,
            ),
            title: Text(
              'gallery',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: AppFonts.Poppins,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.camera_alt_rounded,
              color: Colors.grey,
            ),
            title: Text(
              'take a picture',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: AppFonts.Poppins,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.camera);
            },
          ),
          if (imageFile.value != null)
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              title: Text(
                'delete the image',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: AppFonts.Poppins,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Get.defaultDialog(
                  contentPadding: EdgeInsets.all(10),
                  backgroundColor: Appcolor.backgroundLight,
                  title: "Confirmation",
                  titleStyle: TextStyle(
                    fontFamily: AppFonts.Poppins,
                  ),
                  middleText: "Do you want to erase the profile picture ?",
                  middleTextStyle: TextStyle(
                      color: Colors.grey.shade800,
                      fontFamily: AppFonts.Poppins,
                      fontSize: 15),
                  textConfirm: "delete",
                  textCancel: "cancel",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    clearImage();
                    Get.back();
                  },
                  onCancel: () {},
                );
              },
            ),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return Obx(() {
      return GestureDetector(
        onTap: () => showImagePickerOptions(Get.context!),
        child: CircleAvatar(
          backgroundColor: Appcolor.backgroundLight,
          radius: 60,
          backgroundImage: imageFile.value != null
              ? FileImage(imageFile.value!)
              : AssetImage(Appimages.person) as ImageProvider,
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade100,
              child: Icon(
                Icons.camera_alt,
                size: 20,
                color: Appcolor.base,
              ),
            ),
          ),
        ),
      );
    });
  }
}
