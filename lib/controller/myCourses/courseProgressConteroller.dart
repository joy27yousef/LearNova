import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/model/ProgressCoursesModel.dart';
import 'package:learn_nova/data/source/remote/mycourses/ProgressCourse.dart';

class CoursepProgresscConteroller extends GetxController {
  // الحصول على بيانات الكورس من كونترولر خارجي
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

    // مراقبة التغييرات في الأقسام وتحويلها إلى كائنات CourseSection
    ever(courseDataController.sections, (newSections) {
      if (newSections != null) {
        sections.value = (newSections as List)
            .map((e) => CourseSection.fromJson(e))
            .toList();
      }
    });

    // عند تغيير الأقسام يتم تحميل الفيديوهات المشاهدة وتقدم الكورس
    ever(sections, (_) {
      loadWatchedVideos();
      loadCourseProgress();
    });
  }

  Future<void> loadWatchedVideos() async {
    var response = await getUserVideo.getData();
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      List<dynamic> data = response['watched'] ?? [];
      watchedVideoIds.value = data.map<int>((e) => e as int).toList();

      // لا تعدل هنا progress و completedVideos — سيتم حسابهم قبل التحديث للسيرفر
      update(); // لتحديث واجهة المستخدم بناءً على البيانات الجديدة
    }
  }

  Future<void> loadCourseProgress() async {
    int courseId = courseDataController.data['id'];
    var response = await viewProgress.getData(courseId);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      progress = double.tryParse(response['progress'].toString()) ?? 0.0;
      completedVideos = response['videosCompleted'] == true ? 1 : 0;

      canTakeQuiz = response['canTakeQuiz'] ?? false;

      print(
          "📥📥📥 Loaded progress from server: $progress ($completedVideos videos)");
    }
    update();
  }

  Future<void> markVideoAsWatched() async {
    statusrequest = Statusrequest.loading;
    update();

    var response = await makeWatchedVideo.getData(videoId);
    statusrequest = handilingData(response);

    if (statusrequest == Statusrequest.success) {
      if (!watchedVideoIds.contains(videoId)) { 
        await loadWatchedVideos();
        await updateCourseProgress();
        courseDataController.getQuizesData();
        showCustomSnackbar(
          title: "Well done",
          message: "The video has been successfully completed",
          icon: Icons.done,
          backgroundColor: Colors.green,
        );

        Get.find<MyCoursesControllerIMP>().refreshCourses();
        goToNextVideo(videoId);
      } else {
        showCustomSnackbar(
          title: "Info",
          message: "Video already marked as watched",
          icon: Icons.info,
          backgroundColor: Colors.blue,
        );
      }
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

  bool canOpenVideo(
      int videoId, int sectionIndex, List<CourseVideo> videoList) {
    return true; // يمكنك تعديل المنطق حسب الحاجة
  }

  bool canOpenSection(int sectionIndex) {
    return true; // يمكنك تعديل المنطق حسب الحاجة
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
    int totalVideos = getTotalVideos();
    int completedVideosCount = getCompletedVideosCount();

    if (totalVideos == 0) {
      print("⚠️ No videos in course. Aborting update.");
      return;
    }

    progress = (completedVideosCount / totalVideos) * 100;
    if (progress > 100) progress = 100;

    bool allVideosCompleted = completedVideosCount == totalVideos;

    print("📺 Total Videos: $totalVideos");
    print("✅ Completed Videos: $completedVideosCount");
    print("📊 Calculated Progress: $progress%");

    var response = await updateProgress.getData(
      courseId,
      progress.toInt(),
      allVideosCompleted, // ترسل bool مباشرة
    );

    print(
        "📤 Sending progress: $progress, videos_completed: $allVideosCompleted");
    print("📥 Response: $response");
  }

  int getCompletedVideosCount() {
    int count = 0;
    for (var section in sections) {
      for (var video in section.videos) {
        if (watchedVideoIds.contains(video.id)) {
          count++;
        }
      }
    }
    return count;
  }
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

    // bool canOpenSection(int sectionIndex) {
  //   if (sectionIndex == 0) return true;
  //   var previousVideos = sections[sectionIndex - 1].videos;
  //   return previousVideos.every((v) => watchedVideoIds.contains(v.id));
  // }