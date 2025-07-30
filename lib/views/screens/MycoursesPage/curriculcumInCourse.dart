import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';

import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/screens/MycoursesPage/videoPage.dart';

class CurriculcumInCourse extends StatelessWidget {
  final CourseControllerIMP courseController = Get.find();

  final CoursepProgresscConteroller progressController =
      Get.isRegistered<CoursepProgresscConteroller>()
          ? Get.find()
          : Get.put(CoursepProgresscConteroller());

  CurriculcumInCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sections = courseController.sections;
      final selectedIndex = courseController.selectedIndex.value;
      final videos = courseController.videosOfSelectedModule;

      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("Modules", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),

            /// ======== Tabs (Modules Buttons) =========
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(sections.length, (i) {
                  final section = sections[i];
                  final canOpen = progressController.canOpenSection(i);
                  final isSelected = selectedIndex == i;
                  final allWatched = (progressController.sections[i].videos)
                      .every((v) =>
                          progressController.watchedVideoIds.contains(v.id));

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (!canOpen) {
                          showCustomSnackbar(
                            title: "you can't open this section yet",
                            message:
                                'Watch all the videos of the previous section first',
                            backgroundColor: Colors.grey,
                            icon: Icons.error,
                            textColor: Colors.white,
                          );
                          return;
                        }
                        courseController.changeTab(i);
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected
                              ? Appcolor.base
                              : allWatched
                                  ? Colors.green
                                  : canOpen
                                      ? Theme.of(context).colorScheme.background
                                      : Colors.grey.shade300,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allWatched
                                ? const Icon(Icons.done_rounded,
                                    color: Colors.white)
                                : canOpen
                                    ? const Icon(Icons.lock_open_rounded,
                                        color: Colors.white)
                                    : const Icon(Icons.lock,
                                        color: Colors.grey),
                            const SizedBox(width: 10),
                            Text(
                              '${i + 1}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 20,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : allWatched
                                            ? Colors.white
                                            : Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            /// ======= Section Title =========
            Wrap(
              children: [
                Text(
                  "Section ${selectedIndex + 1} : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15),
                ),
                Text(
                  "${sections[selectedIndex]['title'][translationData()]}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Appcolor.base, fontSize: 15),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// ========== Videos ============
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, i) {
                  final video = videos[i];
                  final title =
                      video['title']?[translationData()] ?? 'No Title';
                  final duration = video['duration'] ?? 0;
                  final videoId = video['id'];

                  final isWatched =
                      progressController.watchedVideoIds.contains(videoId);
                  final canOpen = progressController.canOpenVideo(
                    videoId,
                    selectedIndex,
                    progressController.sections[selectedIndex].videos,
                  );

                  return InkWell(
                    onTap: () {
                      if (!canOpen) {
                        showCustomSnackbar(
                          title: "The video cannot be opened",
                          message: "All previous videos must be watched first",
                          icon: Icons.error,
                          backgroundColor: Colors.red,
                        );
                        return;
                      }

                      Get.to(() => VideoPage(), arguments: {
                        'videoId': videoId,
                        'videoUrl': video['video_url'],
                        'title': title,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Appcolor.baselight4,
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        trailing: const Icon(Icons.video_collection_rounded,
                            color: Appcolor.base),
                        title: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 15),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                '$duration ',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Text(
                                'Min',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: isWatched
                              ? Colors.green
                              : canOpen
                                  ? Appcolor.base
                                  : Colors.grey,
                          child: isWatched
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 20)
                              : canOpen
                                  ? Text(
                                      '${i + 1}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  : const Icon(Icons.lock,
                                      color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
