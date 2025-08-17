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

  // @override
  // void onInit() {
  //   super.onInit();

  //   // مراقبة التغييرات في الأقسام وتحويلها إلى كائنات CourseSection
  //   ever(courseDataController.sections, (newSections) {
  //     if (newSections != null) {
  //       sections.value = (newSections as List)
  //           .map((e) => CourseSection.fromJson(e))
  //           .toList();
  //     }
  //   });

  //   ever(sections, (_) {
  //     loadWatchedVideos();
  //     loadCourseProgress();
  //   });
  // }
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

    ever(sections, (_) async {
      await loadWatchedVideos();

      // تحديث التقدم محلياً بناءً على الفيديوهات المشاهدة
      progress = calculateProgress();
      print(
          "📊 Initial progress calculatedddddddddddddddddddddddddddddddddddddddddddddddddddd: $progress%");
      await updateCourseProgress();
      await loadCourseProgress(); // إذا أردت تحديثه من السيرفر لاحقاً
    });
  }

// دالة لحساب التقدم محلياً
  double calculateProgress() {
    int totalVideos = getTotalVideos();
    if (totalVideos == 0) return 0.0;

    int completedCount = getCompletedVideosCount();
    return (completedCount / totalVideos) * 100;
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
        // تحديث محلي لقائمة الفيديوهات
        watchedVideoIds.add(videoId);

        // تحديث نسبة التقدم محلياً
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
        // إذا الفيديو مشاهد من قبل
        showCustomSnackbar(
          title: "Info",
          message: "Video already watched, moving to next",
          icon: Icons.fast_forward,
          backgroundColor: Colors.blue,
        );

        goToNextVideo(videoId);
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
    if (courseDataController.data['is_sequential'] == 1) {
      int index = videoList.indexWhere((v) => v.id == videoId);
      if (index == 0) {
        if (sectionIndex == 0) return true;
        var previousVideos = sections[sectionIndex - 1].videos;
        return previousVideos.every((v) => watchedVideoIds.contains(v.id));
      }
      return watchedVideoIds.contains(videoList[index - 1].id);
    } else {
      return true;
    }
  }

  bool canOpenSection(int sectionIndex) {
    if (courseDataController.data['is_sequential'] == 1) {
      if (sectionIndex == 0) return true;
      var previousVideos = sections[sectionIndex - 1].videos;
      return previousVideos.every((v) => watchedVideoIds.contains(v.id));
    } else {
      return true;
    }
  }

  void goToNextVideo(int currentVideoId) {
    bool foundCurrent = false;

    for (int s = 0; s < sections.length; s++) {
      var section = sections[s];
      for (int i = 0; i < section.videos.length; i++) {
        if (section.videos[i].id == currentVideoId) {
          foundCurrent = true;
          continue;
        }

        if (foundCurrent) {
          // نتخطى الفيديوهات المشاهدة
          if (watchedVideoIds.contains(section.videos[i].id)) {
            continue;
          }

          // نفتح أول فيديو جديد
          Get.offNamed(AppRoutes.videoPage, arguments: {
            "videoId": section.videos[i].id,
            "title": section.videos[i].title,
            "videoUrl": section.videos[i].videoUrl,
          });
          return;
        }
      }
    }

    // إذا ما في أي فيديو جديد
    showCustomSnackbar(
      title: "🎉 Congratulations",
      message: "You finished all the videos!",
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
