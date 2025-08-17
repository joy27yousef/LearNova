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
  UserControllerIMP user = Get.find<UserControllerIMP>();

  late TextEditingController firstname;
  late TextEditingController lastname;
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

    firstname = TextEditingController(text: user.user['first_name']);
    lastname = TextEditingController(text: user.user['last_name']);
    phone = TextEditingController(text: user.user['phone_number']);
    specialization = TextEditingController(text: user.user['specialization']);
    country = TextEditingController(text: user.user['country']);
    bio = TextEditingController(text: user.user['bio']);
  }

  // @override
  // void onClose() {
  //   firstname.dispose();
  //   lastname.dispose();
  //   phone.dispose();
  //   specialization.dispose();
  //   country.dispose();
  //   bio.dispose();
  //   super.onClose();
  // }

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
  void onReady() {
    super.onReady();

    // تحديث النصوص أول مرة إذا فيه بيانات
    firstname.text = user.user['first_name'] ?? '';
    lastname.text = user.user['last_name'] ?? '';
    phone.text = user.user['phone_number'] ?? '';
    specialization.text = user.user['specialization'] ?? '';
    country.text = user.user['country'] ?? '';
    bio.text = user.user['bio'] ?? '';

    ever(user.user, (_) {
      firstname.text = user.user['first_name'] ?? '';
      lastname.text = user.user['last_name'] ?? '';
      phone.text = user.user['phone_number'] ?? '';

      specialization.text = user.user['specialization'] ?? '';
      country.text = user.user['country'] ?? '';
      bio.text = user.user['bio'] ?? '';
    });
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
              Get.find<UserControllerIMP>().user['profile_image'] != null
                  ? NetworkImage(
                      Get.find<UserControllerIMP>().user['profile_image'])
                  : AssetImage('assets/images/person.png'),
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

  Future<void> editProfile() async {
    if (!validatePartial()) {
      showCustomSnackbar(
        title: 'Validation Error',
        message: 'Please fill the fields correctly.',
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
      return;
    }

    showLoadingDialog('m2'.tr);

    Map<String, dynamic> data = {};

    if (firstname.text != (user.user['first_name'] ?? '') &&
        firstname.text.trim().isNotEmpty) {
      data['first_name'] = firstname.text.trim();
    }
    if (lastname.text != (user.user['last_name'] ?? '') &&
        lastname.text.trim().isNotEmpty) {
      data['last_name'] = lastname.text.trim();
    }
    if (phone.text != (user.user['phone_number'] ?? '') &&
        phone.text.trim().isNotEmpty) {
      data['phone_number'] = phone.text.trim();
    }

    if (specialization.text != (user.user['specialization'] ?? '') &&
        specialization.text.trim().isNotEmpty) {
      data['specialization'] = specialization.text.trim();
    }
    if (country.text != (user.user['country'] ?? '') &&
        country.text.trim().isNotEmpty) {
      data['country'] = country.text.trim();
    }
    if (bio.text != (user.user['bio'] ?? '') && bio.text.trim().isNotEmpty) {
      data['bio'] = bio.text.trim();
    }
    if (imageFile.value != null) {
      data['imageFile'] = imageFile.value;
    }

    var response = await editProfileData.getData(
      firstName: data['first_name'],
      lastName: data['last_name'],
      phone: data['phone_number'],
      specialization: data['specialization'],
      country: data['country'],
      bio: data['bio'],
      imageFile: data['imageFile'],
    );

    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      if (Get.isDialogOpen ?? false) Get.back();
      await Get.find<UserControllerIMP>().getUserData();
      Get.back();
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
    bool isChanged = firstname.text != (user.user['first_name'] ?? '') ||
        lastname.text != (user.user['last_name'] ?? '') ||
        phone.text != (user.user['phone_number'] ?? '') ||
        specialization.text != (user.user['specialization'] ?? '') ||
        country.text != (user.user['country'] ?? '') ||
        bio.text != (user.user['bio'] ?? '') ||
        imageFile.value != null;

    if (!isChanged) return false;

    if (firstname.text != (user.user['first_name'] ?? '') &&
        firstname.text.trim().isEmpty) return false;

    if (lastname.text != (user.user['last_name'] ?? '') &&
        lastname.text.trim().isEmpty) return false;

    if (phone.text != (user.user['phone_number'] ?? '') &&
        phone.text.trim().isEmpty) return false;

    return true;
  }
}
