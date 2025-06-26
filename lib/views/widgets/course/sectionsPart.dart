import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/translationData.dart';

class SectionsPart extends StatelessWidget {
  final CourseControllerIMP controller = Get.find();
  SectionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.sections.length,
              itemBuilder: (context, i) {
                var section = controller.sections[i];
                var sectionTitle = section['title']?[translationData()] ?? '';
                List videos = section['videos'] ?? [];
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
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
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      subtitle: Row(
                        children: [
                          Text(
                            '${videos.length} ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            '88'.tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      collapsedBackgroundColor:
                          Theme.of(context).colorScheme.background,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      iconColor: Appcolor.base,
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Appcolor.base,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            '${i + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 25,
                                ),
                          ),
                        ),
                      ),
                      title: Text(
                        sectionTitle,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 15),
                      ),
                      children: videos.map<Widget>((video) {
                        String videoTitle =
                            video['title']?[translationData()] ?? '';
                        String videoUrl = video['video_url'] ?? '';

                        return ListTile(
                          leading: const Icon(
                            Icons.play_circle_outline,
                            color: Colors.grey,
                          ),
                          title: Text(
                            videoTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                          onTap: () {},
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            )),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
