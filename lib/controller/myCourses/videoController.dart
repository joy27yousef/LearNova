import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    String url = Get.arguments['videoUrl'];
    videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: false,
        );
        isInitialized.value = true;
      });
      print("📺 Video URL: $url");

  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
