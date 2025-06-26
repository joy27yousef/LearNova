import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/widgets/course/SomInfCours.dart';
import 'package:learn_nova/views/widgets/course/bottom.dart';
import 'package:learn_nova/views/widgets/course/descriptionPart.dart';
import 'package:learn_nova/views/widgets/course/scrollViewCourse.dart';
import 'package:learn_nova/views/widgets/course/sectionsPart.dart';

class CoursePage extends StatefulWidget {
  CoursePage({super.key});
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
  Widget build(BuildContext context) {
    final double collapseOffset = 150;
    final bool isCollapsed = scrollOffset > collapseOffset;

    return GetBuilder<CourseControllerIMP>(builder: (controller) {
      return Scaffold(
        body: Handilingdataview(
          statusrequest: controller.statusrequest,
          widget: Stack(
            children: [
              GetBuilder<CourseControllerIMP>(
                  builder: (controller) => CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          SliverAppBar(
                            actions: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  icon: Icon(Iconsax.heart),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                            scrolledUnderElevation: 0,
                            pinned: true,
                            expandedHeight: 220,
                            leading: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new),
                              onPressed: () => Get.back(),
                            ),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 5, right: 5),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    controller.data['thumbnail_url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            centerTitle: true,
                            title: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              switchInCurve: Curves.easeIn,
                              switchOutCurve: Curves.easeOut,
                              child: isCollapsed
                                  ? Text(
                                      controller.data['title']
                                          [translationData()],
                                      key: ValueKey('collapsedTitle'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)
                                  : SizedBox.shrink(key: ValueKey('empty')),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: isCollapsed ? 0.0 : 1.0,
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            controller.data['title']
                                                    [translationData()] ??
                                                '',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  fontSize: 20,
                                                )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.monetization_on,
                                              color: Appcolor.base,
                                            ),
                                            Text(
                                              "52",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: Appcolor.base),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
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
                                  SizedBox(height: 20),
                                  ScrollViewCourse(),
                                  Obx(() {
                                    final views = [
                                      DescriptionPart(),
                                      SectionsPart(),
                                    ];

                                    return AnimatedSwitcher(
                                      duration: Duration(milliseconds: 300),
                                      transitionBuilder: (child, animation) =>
                                          FadeTransition(
                                              opacity: animation, child: child),
                                      child: Container(
                                        key: ValueKey(
                                            controller.selectedIndex.value),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: views[
                                            controller.selectedIndex.value],
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
              Bottom(),
            ],
          ),
        ),
      );
    });
  }
}
