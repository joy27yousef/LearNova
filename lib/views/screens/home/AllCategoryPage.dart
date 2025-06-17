import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/data/source/static.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Explor by Category',
            style: Theme.of(context).appBarTheme.titleTextStyle,
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
                color: Theme.of(context).colorScheme.background,
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
