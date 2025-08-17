import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/TextFormGen.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  CourseControllerIMP controller = Get.find();
  late YoutubePlayerController youtubeController;
  late String title;
  late int videoID;
  OverlayEntry? overlayEntry;

  final List<Color> cardColors = [
    Colors.blue.shade100,
    Colors.amber.shade100,
    Colors.green.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
    Colors.pink.shade100,
  ];
  final random = Random();

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

  @override
  void initState() {
    super.initState();
    final videoUrl = Get.arguments['videoUrl'];
    title = Get.arguments['title'];
    videoID = Get.arguments['videoId'];

    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
    controller.getAllVideoNotes(controller.idCourse!, videoID);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    youtubeController.dispose();
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
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
                                iconform: const Icon(Icons.notes_rounded,
                                    color: Colors.grey),
                                mycontroller: controller.content,
                                typekey: TextInputType.multiline,
                                valid: (val) => val == null || val.isEmpty
                                    ? 'Enter content'
                                    : null,
                              ),
                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (controller.formstate.currentState!
                                        .validate()) {
                                      controller.addNote(videoID);
                                    }
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  label: const Text(
                                    'Add Note',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Appcolor.base,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                  );
                },
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Container(
                  width: 80,
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Appcolor.base, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.background),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.add, color: Appcolor.base),
                        Text(
                          'Note',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Appcolor.base, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Notes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(() {
                      final filteredNotes = controller.allNotes
                          .where((note) => note['video_id'] == videoID)
                          .toList();

                      if (filteredNotes.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 45),
                              Image.asset(
                                Appimages.addNotes,
                                width: 60,
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  "No notes currently available",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 3 / 2,
                        ),
                        itemCount: filteredNotes.length,
                        itemBuilder: (context, index) {
                          final note = filteredNotes[index];
                          Color notescolor =
                              cardColors[random.nextInt(cardColors.length)];

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onLongPressStart: (details) {
                              showNoteMenu(
                                  context, details.globalPosition, note);
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
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 80), // مساحة لظهور الزر فوق المحتوى
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    var progressController =
                        Get.find<CoursepProgresscConteroller>();
                    progressController.videoId = Get.arguments['videoId'];
                    await progressController.markVideoAsWatched();
                  },
                  backgroundColor: Appcolor.base,
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
