import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/data/source/static.dart';
import 'package:learn_nova/test.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Appcolor.backgroundColor,
          title: Text(
            'Explor by Category',
            style: TextStyle(
                fontFamily: AppFonts.Poppins, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: GridView.builder(
            itemCount: categoryTest.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 10),
            itemBuilder: (context, i) => InkWell(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onTap: () {
                Get.toNamed(AppRoutes.mainCategory);
              },
              child: Card(
                shadowColor: Colors.white,
                elevation: 2,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      categoryTest[i].image!,
                      width: 70,
                    ),
                    Text(
                      categoryTest[i].name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: AppFonts.Poppins,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
