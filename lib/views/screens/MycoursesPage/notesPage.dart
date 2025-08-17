import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/TextFormGen.dart';

class AllNotesPage extends StatelessWidget {
  CourseControllerIMP controller = Get.find();
  OverlayEntry? overlayEntry;

  void showNoteMenu(
      BuildContext context, Offset position, Map<String, dynamic> note) {
    overlayEntry?.remove();
    var noteid = note['id'];
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy - 50,
        left: position.dx - 40,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Iconsax.trash, color: Colors.red),
              onPressed: () {
                overlayEntry?.remove();
                overlayEntry = null;
                controller.deleteNote(noteid);
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  final List<Color> cardColors = [
    Colors.blue.shade100,
    Colors.amber.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.pink.shade100,
  ];
  final random = Random();

  AllNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.statusrequest == Statusrequest.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.allNotes.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Appimages.notebook,
                width: 280,
              ),
              Center(
                  child: Text(
                "no notes currently available",
                style: Theme.of(context).textTheme.titleMedium,
              )),
              SizedBox(
                height: 80,
              )
            ],
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.allNotes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, i) {
              var note = controller.allNotes[i];
              Color notescolor = cardColors[random.nextInt(cardColors.length)];

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPressStart: (details) {
                  showNoteMenu(context, details.globalPosition, note);
                },
                onTap: () {
                  Get.toNamed(AppRoutes.editnotepage,
                      arguments: {'noteId': note['id']});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: notescolor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note['title'] ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 15, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            note['content'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 12, color: Colors.black),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // شريط صغير أعلى الـ BottomSheet
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Image.asset(Appimages.addNotes, width: 100),
                      const SizedBox(height: 20),

                      Text(
                        'Add Note',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),

                      // حقل العنوان
                      TextFormGen(
                        hint: 'Title',
                        lable: 'Title',
                        iconform: const Icon(Icons.text_fields_rounded,
                            color: Colors.grey),
                        mycontroller: controller.noteTitle,
                        typekey: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      TextFormGen(
                        hint: 'Content',
                        lable: 'Content',
                        iconform:
                            const Icon(Icons.notes_rounded, color: Colors.grey),
                        mycontroller: controller.content,
                        typekey: TextInputType.multiline,
                        valid: (val) =>
                            val == null || val.isEmpty ? 'Enter content' : null,
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (controller.formstate.currentState!.validate()) {
                              controller.addNote();
                            }
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Note',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.base,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Appcolor.base),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
