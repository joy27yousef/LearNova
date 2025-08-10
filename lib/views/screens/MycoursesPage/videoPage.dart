import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/courseProgressConteroller.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController youtubeController;
  late String title;

  @override
  void initState() {
    super.initState();
    final videoUrl = Get.arguments['videoUrl'];
    title = Get.arguments['title'];

    final videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    // رجع الاتجاه للوضع الرأسي عند مغادرة الصفحة
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    youtubeController.dispose();
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
          //
                Get.back();
              },
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Spacer(), // يضمن زر Next في الاسفل
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Boxtext(
              textin: "Next",
              onTapFun: () async {
                var progressController =
                    Get.find<CoursepProgresscConteroller>();
                progressController.videoId = Get.arguments['videoId'];
                await progressController.markVideoAsWatched();
              },
            ),
          ),
        );
      },
    );
  }
}
