import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/data/source/static.dart';

class Categorywidget extends StatelessWidget {
  const Categorywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 65,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (contex, i) => InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.mainCategory);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey.shade200,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 27,
                          child: Image.asset(
                            categoryTest[i].image!,
                            width: 40,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        categoryTest[i].name!,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
