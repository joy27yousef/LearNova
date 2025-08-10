import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/user.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

abstract class UserController extends GetxController {
  static var find;

  onInit();
}

class UserControllerIMP extends UserController {
  File? imageFile;
  late Statusrequest statusrequest;

  UserData userData = UserData(crud: Get.find<Crud>());
  final RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() async {
    var response = await userData.getData();
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      print('✅ success to load user data');
      print(response);
      user.clear();
      user.value = Map<String, dynamic>.from(response);
    } else {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      statusrequest = Statusrequest.failure;
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    } else {
      print('❗ No image selected.');
    }
  }
}
