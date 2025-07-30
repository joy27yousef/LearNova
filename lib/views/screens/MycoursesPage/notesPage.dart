import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
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
                controller.deleteNote(context, noteid);
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
    return Obx(() {
      if (controller.statusrequest == Statusrequest.loading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.allNotes.isEmpty) {
        return const Center(child: Text("لا توجد ملاحظات حاليًا"));
      }

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          overlayEntry?.remove();
          overlayEntry = null;
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.allNotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemBuilder: (context, i) {
                      var note = controller.allNotes[i];
                      Color notescolor =
                          cardColors[random.nextInt(cardColors.length)];

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onLongPressStart: (details) {
                          showNoteMenu(context, details.globalPosition, note);
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
                                  note['title'] ?? 'No title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Expanded(
                                  child: Text(
                                    note['content'] ?? '',
                                    style: const TextStyle(fontSize: 12),
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
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: '',
                    content: Container(
                      height: 400,
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Image.asset(Appimages.addNotes, width: 100),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Add note',
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormGen(
                            hint: 'content',
                            lable: 'content',
                            iconform: const Icon(Icons.text_fields_rounded,
                                color: Colors.grey),
                            mycontroller: controller.content,
                            typekey: TextInputType.multiline,
                            valid: (val) => validInput(val!, 5, 100, 'note'),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () => controller.addNote(context),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Appcolor.base,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'add note',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => Get.back(),
                            child: Text(
                              'cancel',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Appcolor.base,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Appcolor.baselight3,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
