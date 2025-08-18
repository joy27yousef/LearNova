import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/mainPageController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:learn_nova/core/function/favoriteHeart.dart';
import 'package:learn_nova/core/function/openCertificateUrl.dart';
import 'package:learn_nova/core/function/translationData.dart';
import 'package:learn_nova/views/screens/main_page.dart';
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
  final MyCoursesControllerIMP myCourseController = Get.find();
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
          statusrequests: [controller.statusrequest],
          widget: GetBuilder<CourseControllerIMP>(builder: (controller) {
            return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      actions: [
                        FavoriteHeart(courseId: controller.data['id']),
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            if (controller.data['link'] == null) {
                              showCustomSnackbar(
                                  title: 'm3'.tr,
                                  message: 'a3'.tr,
                                  icon: Icons.done_rounded,
                                  backgroundColor: Colors.grey);
                            } else {
                              openUrl(controller.data['link']);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              FontAwesomeIcons.link,
                            ),
                          ),
                        ),
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
                              Text(
                                controller.data['price'] == '0.00'
                                    ? 'Free'
                                    : "${controller.data['price']} SPY",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.green),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                // Bottom(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 10, right: 8),
                    child: Obx(() => InkWell(
                          onTap: () {
                            if (controller.isEnrolled.value) {
                              Get.find<MainpagecontrollerIMP>().changePage(1);
                              Get.offAll(() => MainPage());
                            } else {
                              if (controller.data['price'] == "0.00") {
                                confirmationAelrt(
                                  Appimages.enroll,
                                  'Would you really like to enroll in this course ??',
                                  "No, I don't want",
                                  'Yes, Enroll',
                                  Appcolor.base,
                                  () async {
                                    await myCourseController.getMyCourses(
                                        Get.find<UserControllerIMP>()
                                            .user['id']);
                                    controller.checkEnrollment();
                                    await controller.enroll();
                                  },
                                );
                              } else {
                                Get.toNamed(AppRoutes.paymentPage, arguments: {
                                  'id': controller.data['id'],
                                  'title': controller.data['title']
                                      [translationData()],
                                  'image': controller.data['thumbnail_url'],
                                  'price': controller.data['price'],
                                  'duration': controller.data['duration']
                                      [translationData()],
                                  'difficulty_level':
                                      controller.data['difficulty_level'],
                                });
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Appcolor.base,
                            ),
                            child: Center(
                              child: Text(
                                controller.isEnrolled.value
                                    ? 'Go to course'
                                    : 'Enroll Now',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
