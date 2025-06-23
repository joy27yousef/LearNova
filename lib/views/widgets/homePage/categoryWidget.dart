import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/categoryController.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/translationData.dart';

class Categorywidget extends StatelessWidget {
  const Categorywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryControllerIMP>(
        builder: (controller) => Container(
              padding: EdgeInsets.all(5),
              height: 65,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (contex, i) => InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.mainCategory,
                            arguments: {
                              'subcategories': controller.maincategories[i]
                                  ['children'],
                              'title': controller.maincategories[i]['name']
                                  [translationData()],
                              'mainCategoryId': controller.maincategories[i]
                                  ['id'],
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Center(
                            child: Text(
                              controller.maincategories[i]['name']
                                  [translationData()],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      )),
            ));
  }
}
