import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/categoryController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/category/courseViewinMainCat.dart';
import 'package:learn_nova/views/widgets/category/rolinMainCat.dart';

class MainCategory extends StatelessWidget {
  //initial

  final CategoryControllerIMP controller = Get.put(CategoryControllerIMP());

  final String title = Get.arguments['title'];

  MainCategory({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    controller.changeTab(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectedCategoryId.value = 0;
      controller.selectedIndex.value = 0;
      controller.update();
    });

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () {
                Get.toNamed(AppRoutes.searhPage);
              },
              child: Image.asset(
                Appimages.search,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Handilingdataview(
        statusrequest: controller.statusrequest,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RolinMainCat(),
            CourseViewinMainCat(),
          ],
        ),
      )),
    );
  }
}
