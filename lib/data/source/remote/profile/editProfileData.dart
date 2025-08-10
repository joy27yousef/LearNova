import 'dart:io';

import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class EditProfileData {
  Crud? crud;
  EditProfileData({this.crud});

  Future<dynamic> getData({
    String? firstName,
    String? lastName,
    String? phone,
    File? imageFile,
    String? bio,
    String? specialization,
    String? country,
  }) async {
    Map<String, dynamic> data = {};

    if (firstName != null && firstName.trim().isNotEmpty) {
      data["firstName"] = firstName.trim();
    }
    if (lastName != null && lastName.trim().isNotEmpty) {
      data["lastName"] = lastName.trim();
    }
    if (phone != null && phone.trim().isNotEmpty) {
      data["phoneNumber"] = phone.trim();
    }
    if (bio != null && bio.trim().isNotEmpty) {
      data["bio"] = bio.trim();
    }
    if (specialization != null && specialization.trim().isNotEmpty) {
      data["specialization"] = specialization.trim();
    }
    if (country != null && country.trim().isNotEmpty) {
      data["country"] = country.trim();
    }

    // لو ما في أي بيانات للحقل، data رح تكون فاضية {}

    var response = await crud!.postRequestWithFileDio(
      url: Applinks.editProfile,
      data: data,
      file: imageFile,
      fileFieldName: "profile_image",
      withToken: true,
    );

    return response.fold((l) => l, (r) => r);
  }
}
