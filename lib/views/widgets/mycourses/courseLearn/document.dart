import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/openCertificateUrl.dart';

class Documents extends StatelessWidget {
  CourseControllerIMP controller = Get.find();
  Documents({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.data['documents'] == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Appimages.noData, height: 175),
          const SizedBox(height: 20),
          Text(
            "There are no documents yet",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عمودين
            crossAxisSpacing: 15, // مسافة أفقية
            mainAxisSpacing: 15, // مسافة عمودية
            childAspectRatio: 0.8, // مستطيل عمودي (غَيِّر الرقم حسب التصميم)
          ),
          itemCount: controller.data['documents'].length,
          itemBuilder: (context, i) => InkWell(
            onTap: () {
              openUrl(controller.data['documents'][i]['url']);
            },
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Image.asset(
                      Appimages.doc,
                      width: 75,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        controller.data['documents'][i]['title'],
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      Text(
                        controller.data['documents'][i]['type'],
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.normal, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
