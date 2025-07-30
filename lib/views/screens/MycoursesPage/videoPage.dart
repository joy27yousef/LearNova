import 'package:flutter/material.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late String videoUrl;
  late String title;
  bool isYoutube = false;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  YoutubePlayerController? youtubeController;

  @override
  void initState() {
    super.initState();
    videoUrl = Get.arguments['videoUrl'];
    title = Get.arguments['title'];
    isYoutube =
        videoUrl.contains("youtube.com") || videoUrl.contains("youtu.be");

    if (isYoutube) {
      final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true),
      );
    } else {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl))
            ..initialize().then((_) {
              chewieController = ChewieController(
                videoPlayerController: videoPlayerController!,
                autoPlay: true,
                looping: false,
              );
              setState(() {});
            });
    }
  }

  @override
  void dispose() {
    youtubeController?.dispose();
    chewieController?.dispose();
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(
          //   textAlign: TextAlign.center,
          //   softWrap: true,
          //   overflow: TextOverflow.clip,
          //   title,
          //   style: Theme.of(context)
          //       .appBarTheme
          //       .titleTextStyle!
          //       .copyWith(fontSize: 16),
          // ),
          ),
      body: ListView(
        children: [
          Center(
            child: isYoutube
                ? YoutubePlayer(controller: youtubeController!)
                : chewieController != null &&
                        chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(controller: chewieController!)
                    : const CircularProgressIndicator(),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Boxtext(
              textin: "Next",
              onTapFun: () async {
                var progressController = Get.find<CoursepProgresscConteroller>();
                progressController.videoId = Get.arguments['videoId'];
                await progressController.markVideoAsWatched();
              },
            ),
          ),
        ],
      ),
    );
  }
}
