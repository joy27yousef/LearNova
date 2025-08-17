import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/editNoteController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/reviewForm.dart';

class EditNotePage extends StatelessWidget {
  EditNotePage({super.key});
  final EditNoteController controller = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text("Edit your note"),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formstate,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "Update your note details below. You can modify both the title and the content of your note.",
                textAlign: TextAlign.justify,
                textScaleFactor: 0.9,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 17),
              ),
              const SizedBox(height: 20),
              Text(
                'Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ReviewForm(
                hint: 'Edit note title',
                mycontroller: controller.title,
                typekey: TextInputType.text,
                valid: (val) => validInput(val!, 1, 100, 'name'),
              ),
              const SizedBox(height: 20),

              // Content field
              Text(
                'Content',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ReviewForm(
                hint: 'Edit note content',
                mycontroller: controller.content,
                typekey: TextInputType.multiline,
                valid: (val) => validInput(val!, 1, 1000, 'name'),
              ),

              const SizedBox(height: 50),

              // Send button
              Boxtext(
                textin: 'Save Changes',
                onTapFun: () {
                  confirmationAelrt(
                    Appimages.edit,
                    'Are you sure you want to edit the note?',
                    'No, keep it',
                    'Yes, edit it',
                    Appcolor.base,
                    () {
                      controller.editNotes(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
