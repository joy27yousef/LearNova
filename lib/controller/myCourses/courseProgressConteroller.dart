import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/model/ProgressCoursesModel.dart';
import 'package:learn_nova/data/source/remote/mycourses/ProgressCourse.dart';

class CoursepProgresscConteroller extends GetxController {
  CourseControllerIMP courseDataController = Get.find();

  late Statusrequest statusrequest;
  MakeWatchedVideo makeWatchedVideo = MakeWatchedVideo(crud: Get.find<Crud>());
  ViewProgress viewProgress = ViewProgress(crud: Get.find<Crud>());
  UpdateProgress updateProgress = UpdateProgress(crud: Get.find<Crud>());
  GetUserVideo getUserVideo = GetUserVideo(crud: Get.find<Crud>());

  late int videoId;

  RxList<int> watchedVideoIds = <int>[].obs;

  RxList<CourseSection> sections = <CourseSection>[].obs;

  double progress = 0.0;
  int completedVideos = 0;
  bool canTakeQuiz = false;

  @override
  void onInit() {
    super.onInit();
    ever(courseDataController.sections, (newSections) {
      if (newSections != null) {
        sections.value = (newSections as List)
            .map((e) => CourseSection.fromJson(e))
            .toList();
      }
    });
    ever(sections, (_) {
      loadWatchedVideos();
      loadCourseProgress();
    });
  }

  loadWatchedVideos() async {
    var response = await getUserVideo.getData();
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      List<dynamic> data = response['watched'] ?? [];
      watchedVideoIds.value = data.map<int>((e) => e as int).toList();
    }
    update();
  }

  loadCourseProgress() async {
    int courseId = courseDataController.data['id'];
    var response = await viewProgress.getData(courseId);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      progress = double.parse(response['progress'].toString());
      completedVideos =
          response['videosCompleted'] is int ? response['videosCompleted'] : 0;

      canTakeQuiz = response['canTakeQuiz'] ?? false;
    }
    update();
  }

  markVideoAsWatched() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await makeWatchedVideo.getData(videoId);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      if (!watchedVideoIds.contains(videoId)) {
        watchedVideoIds.add(videoId);
        completedVideos++;
        await updateCourseProgress();
      }

      showCustomSnackbar(
        title: "Well done",
        message: "The video has been successfully completed",
        icon: Icons.done,
        backgroundColor: Colors.green,
      );

      goToNextVideo(videoId);
    } else {
      showCustomSnackbar(
        title: "The transition failed for the next video",
        message: "Try again..",
        icon: Icons.error,
        backgroundColor: Colors.red,
      );
    }

    update();
  }

  // bool canOpenVideo(
  //     int videoId, int sectionIndex, List<CourseVideo> videoList) {
  //   int index = videoList.indexWhere((v) => v.id == videoId);

  //   if (index == 0) {
  //     if (sectionIndex == 0) return true;
  //     var previousVideos = sections[sectionIndex - 1].videos;
  //     return previousVideos.every((v) => watchedVideoIds.contains(v.id));
  //   }

  //   return watchedVideoIds.contains(videoList[index - 1].id);
  // }
  bool canOpenVideo(
      int videoId, int sectionIndex, List<CourseVideo> videoList) {
    return true;
  }

  // bool canOpenSection(int sectionIndex) {
  //   if (sectionIndex == 0) return true;
  //   var previousVideos = sections[sectionIndex - 1].videos;
  //   return previousVideos.every((v) => watchedVideoIds.contains(v.id));
  // }
  bool canOpenSection(int sectionIndex) {
    return true; // كل الأقسام صارت مفتوحة
  }

  void goToNextVideo(int currentVideoId) {
    for (int s = 0; s < sections.length; s++) {
      var section = sections[s];
      for (int i = 0; i < section.videos.length; i++) {
        if (section.videos[i].id == currentVideoId) {
          if (i + 1 < section.videos.length) {
            var nextVideo = section.videos[i + 1];
            Get.offNamed(AppRoutes.videoPage, arguments: {
              "videoId": nextVideo.id,
              "title": nextVideo.title,
              "videoUrl": nextVideo.videoUrl,
            });

            return;
          } else if (s + 1 < sections.length) {
            var nextSection = sections[s + 1];
            if (nextSection.videos.isNotEmpty) {
              var nextVideo = nextSection.videos[0];
              Get.offNamed(AppRoutes.videoPage, arguments: {
                "videoId": nextVideo.id,
                "title": nextVideo.title,
                "videoUrl": nextVideo.videoUrl,
              });
              return;
            }
          }
        }
      }
    }

    showCustomSnackbar(
      title: "🎉 Congratulations",
      message: "you finished all the videos!",
      icon: Icons.celebration,
      backgroundColor: Appcolor.base,
    );
  }

  int getTotalVideos() {
    return sections.fold(0, (sum, section) => sum + section.videos.length);
  }

  Future<void> updateCourseProgress() async {
    int courseId = courseDataController.data['id'];
    progress = (completedVideos / getTotalVideos()) * 100;
    await updateProgress.getData(courseId, progress.toInt(), completedVideos);
  }
}
