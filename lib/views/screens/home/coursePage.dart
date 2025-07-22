import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/favoriteHeart.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/widgets/course/SomInfCours.dart';
import 'package:learn_nova/views/widgets/course/bottom.dart';
import 'package:learn_nova/views/widgets/course/descriptionPart.dart';
import 'package:learn_nova/views/widgets/course/scrollViewCourse.dart';
import 'package:learn_nova/views/widgets/course/sectionsPart.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseControllerIMP controller = Get.put(CourseControllerIMP());
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double collapseOffset = 150;
    final bool isCollapsed = scrollOffset > collapseOffset;

    return GetBuilder<CourseControllerIMP>(builder: (controller) {
      return Scaffold(
        body: Handilingdataview(
          statusrequest: controller.statusrequest,
          widget: GetBuilder<CourseControllerIMP>(builder: (controller) {
            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      actions: [
                        FavoriteHeart(courseId: controller.data['id']),
                      ],
                      scrolledUnderElevation: 0,
                      pinned: true,
                      expandedHeight: 220,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Get.back(),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.background,
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: controller.data['thumbnail_url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      centerTitle: true,
                      title: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: isCollapsed
                            ? Text(
                                controller.data['title'][translationData()],
                                key: const ValueKey('collapsedTitle'),
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            : const SizedBox.shrink(key: ValueKey('empty')),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isCollapsed ? 0.0 : 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  controller.data['title'][translationData()] ??
                                      '',
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Appcolor.base,
                                  ),
                                  Text(
                                    "52",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: Appcolor.base),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SomInfCours(),
                            const SizedBox(height: 20),
                            ScrollViewCourse(),
                            Obx(() {
                              final views = [
                                const DescriptionPart(),
                                SectionsPart(),
                              ];
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                        opacity: animation, child: child),
                                child: Container(
                                  key: ValueKey(controller.selectedIndex.value),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: views[controller.selectedIndex.value],
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Bottom(),
              ],
            );
          }),
        ),
      );
    });
  }
}
