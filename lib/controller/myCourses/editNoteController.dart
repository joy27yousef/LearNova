import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/core/function/loadindDialog.dart';
import 'package:learn_nova/data/source/remote/mycourses/notes.dart';

class EditNoteController extends GetxController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  EditNotesData editNotesData = EditNotesData(crud: Get.find<Crud>());
  CourseControllerIMP corseController = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  late TextEditingController content;
  late TextEditingController title;
  late int noteId;
  Map<String, dynamic>? note;

  @override
  void onInit() {
    super.onInit();

    noteId = Get.arguments['noteId'];
    print("📝 Editing Note ID: $noteId");

    note = corseController.allNotes.firstWhere(
      (n) => n['id'] == noteId,
      orElse: () => {},
    );

    content = TextEditingController(text: note?['content'] ?? '');
    title = TextEditingController(text: note?['title'] ?? '');
  }

  editNotes(BuildContext context) async {
    if (!(formstate.currentState?.validate() ?? false)) {
      return;
    }

    showLoadingDialog('m2'.tr);

    var response = await editNotesData.getData(
      noteId,
      content.text,
      title.text,
    );

    statusrequest = handilingData(response);

    if (Statusrequest.success == statusrequest) {
      await Get.find<CourseControllerIMP>().getAllNotes(
        Get.find<CourseControllerIMP>().idCourse,
      );

      if (Get.isDialogOpen ?? false) Get.back(); // close loading
      Get.back();
      Get.back();

      showCustomSnackbar(
        title: 'nnn'.tr,
        message: 'nn'.tr,
        icon: Icons.done_rounded,
        backgroundColor: Colors.green,
      );
    } else {
      if (Get.isDialogOpen ?? false) Get.back();

      showCustomSnackbar(
        title: 'm4'.tr,
        message: 'a2'.tr,
        icon: Icons.error,
        backgroundColor: Colors.red,
      );

      statusrequest = Statusrequest.failure;
    }
    update();
  }
}
