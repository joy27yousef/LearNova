import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/categoryController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class MainCategory extends StatelessWidget {
  final controller = Get.find<CategoryControllerIMP>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Name of Main Cat',
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
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.subcategories.length,
                  itemBuilder: (context, i) {
                    return Obx(() {
                      bool isSelected = controller.selectedIndex.value == i;
                      return InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => controller.changeTab(i),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color.fromARGB(255, 219, 210, 255)
                                : Colors.grey[100],
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              controller.subcategories[i],
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.Poppins,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w400,
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 150,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              blurStyle: BlurStyle.outer,
                              color: Colors.grey.shade300)
                        ],
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/testpop1.jpg'))),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Interfase Design",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Meta",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.book,
                                      color: Appcolor.base,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      '24 Lessons',
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Iconsax.star1,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      '3.3',
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " 24.00 \$",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(Iconsax.heart_add),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
