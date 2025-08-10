import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/profile/editProfileData.dart';

abstract class EditprofileController extends GetxController {
  late Statusrequest statusrequest;
  EditProfileData editProfileData = EditProfileData(crud: Get.find<Crud>());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController country;
  late TextEditingController specialization;
  late TextEditingController bio;

  void pickImage(ImageSource source) {}
  Widget buildProfileImage();
}

class EditprofileControllerIMP extends EditprofileController {
  final ImagePicker _picker = ImagePicker();

  Rx<File?> imageFile = Rx<File?>(null);
  String? imageBase64;

  @override
  void onInit() {
    super.onInit();

    firstname = TextEditingController();
    lastname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    specialization = TextEditingController();
    country = TextEditingController();
    bio = TextEditingController();
  }

  @override
  void onClose() {
    firstname.dispose();
    lastname.dispose();
    phone.dispose();
    email.dispose();
    specialization.dispose();
    country.dispose();
    bio.dispose();
    super.onClose();
  }

  @override
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        imageFile.value = file;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.grey),
            title: Text(
              'Gallery',
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
            leading: const Icon(Icons.camera_alt_rounded, color: Colors.grey),
            title: Text(
              'Take a picture',
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
        ],
      ),
    );
  }

  @override
  Widget buildProfileImage() {
    return Obx(() {
      return GestureDetector(
        onTap: () => showImagePickerOptions(Get.context!),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Appcolor.backgroundLight,
          backgroundImage:
              Get.find<UserControllerIMP>().user['profile_image'] == null
                  ? NetworkImage(
                      Get.find<UserControllerIMP>().user['profile_image'])
                  : AssetImage('assets/images/person.png') as ImageProvider,
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

  Future<void> editProfile(BuildContext context) async {
    if (firstname.text.isEmpty &&
        lastname.text.isEmpty &&
        phone.text.isEmpty &&
        email.text.isEmpty &&
        country.text.isEmpty &&
        specialization.text.isEmpty &&
        bio.text.isEmpty &&
        imageFile.value == null) {
      showCustomSnackbar(
        title: 'Validation Error',
        message: 'Please fill at least one field or select an image to update.',
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
      return; // ممنوع الإرسال
    }

    if (!validatePartial()) {
      showCustomSnackbar(
        title: 'Validation Error',
        message: 'Please fill the fields correctly.',
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
      return;
    }

    showLoadingDialog(context, 'm2'.tr);

    var response = await editProfileData.getData(
      firstName: firstname.text,
      lastName: lastname.text,
      phone: phone.text,
      imageFile: imageFile.value, // أرسل ملف الصورة مباشرة
      bio: bio.text,
      specialization: specialization.text,
      country: country.text,
    );

    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      if (Get.isDialogOpen ?? false) Get.back();

      Get.find<UserControllerIMP>().getUserData();

      showCustomSnackbar(
        title: 'The operation was successful'.tr,
        message: 'User data has been successfully modified'.tr,
        icon: Icons.done_rounded,
        backgroundColor: Colors.green,
      );
    } else {
      if (Get.isDialogOpen ?? false) Get.back();

      showCustomSnackbar(
        title: 'Failed to modify user data'.tr,
        message: 'a2'.tr,
        icon: Icons.error,
        backgroundColor: Colors.red,
      );

      statusrequest = Statusrequest.failure;
    }

    update();
  }

  bool validatePartial() {
    return firstname.text.isNotEmpty ||
        lastname.text.isNotEmpty ||
        phone.text.isNotEmpty ||
        email.text.isNotEmpty ||
        country.text.isNotEmpty ||
        specialization.text.isNotEmpty ||
        bio.text.isNotEmpty ||
        imageFile.value != null;
  }
}
