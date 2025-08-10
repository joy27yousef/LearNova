import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/homePageController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/function/translationData.dart';

class RolinMainCat extends StatelessWidget {
  final HomepagecontrollerIMP controller = Get.put(HomepagecontrollerIMP());

  late final List subcategoriesWithAll;
  final List subcategories = Get.arguments['subcategories'];
  RolinMainCat({Key? key}) : super(key: key) {
    subcategoriesWithAll = [
      {
        'id': 0,
        'name': {'en': 'All', 'ar': 'الكل'}
      }
    ];
    subcategoriesWithAll.addAll(subcategories);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subcategoriesWithAll.length,
        itemBuilder: (context, i) {
          return Obx(() {
            // int selectedID = controller.selectedCategoryId.value;
            bool isSelected = controller.selectedIndex.value == i;
            return InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                controller.changeTab(i);
                controller.selectedCategoryId.value =
                    subcategoriesWithAll[i]['id'];
                controller.update();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromARGB(255, 219, 210, 255)
                      : Theme.of(context).colorScheme.background,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    subcategoriesWithAll[i]['name'][translationData()],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Appcolor.base : Colors.grey,
                        ),
                    softWrap: true,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
