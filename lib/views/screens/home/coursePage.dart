import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/widgets/course/SomInfCours.dart';
import 'package:learn_nova/views/widgets/course/baseView.dart';
import 'package:learn_nova/views/widgets/course/baseView2.dart';
import 'package:learn_nova/views/widgets/course/bottom.dart';

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
                            pinned: true,
                            expandedHeight: 220,
                            leading: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new),
                              onPressed: () => Get.back(),
                            ),
                            backgroundColor: Colors.white,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 5, right: 5),
                                decoration: BoxDecoration(
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
                                child: Text(
                                  controller.data['title'][translationData()] ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  SizedBox(height: 20),
                                  BaseView(),
                                  BaseView2(),
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
