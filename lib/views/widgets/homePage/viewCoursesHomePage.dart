import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';

class Viewcourseshomepage extends StatelessWidget {
  const Viewcourseshomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, i) => InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                onTap: () {
                  Get.toNamed(AppRoutes.coursePage);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/images/testpop1.jpg'))),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "User Interfase Design",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "Meta",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
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
                            children: [
                              Icon(
                                Iconsax.star1,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 3),
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
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " 24.00 \$",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Iconsax.heart_add),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
