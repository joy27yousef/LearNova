import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:lottie/lottie.dart';

class SomInfCours extends StatelessWidget {
  SomInfCours({super.key});
  CourseControllerIMP controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              LottieBuilder.asset(
                Appimages.individual,
                width: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                controller.data['teacher']['name'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              LottieBuilder.asset(
                Appimages.advantage,
                width: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                controller.data['difficulty_level'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              LottieBuilder.asset(
                Appimages.advantage,
                width: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'begener',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 18),
              )
            ],
          ),
        ],
      ),
      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             LottieBuilder.asset(
      //               Appimages.individual,
      //               width: 30,
      //             ),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Text(
      //               'name of teacher',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .titleMedium!
      //                   .copyWith(fontWeight: FontWeight.normal),
      //             )
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Row(
      //           children: [
      //             LottieBuilder.asset(Appimages.plusperson, width: 30),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Text(
      //               'number of people',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .titleMedium!
      //                   .copyWith(fontWeight: FontWeight.normal),
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       width: 30,
      //     ),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             LottieBuilder.asset(
      //               Appimages.time,
      //               width: 30,
      //             ),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Text(
      //               'time',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .titleMedium!
      //                   .copyWith(fontWeight: FontWeight.normal),
      //             )
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Row(
      //           children: [
      //             LottieBuilder.asset(
      //               Appimages.advantage,
      //               width: 30,
      //             ),
      //             SizedBox(
      //               width: 5,
      //             ),
      //             Text(
      //               'begener',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .titleMedium!
      //                   .copyWith(fontWeight: FontWeight.normal),
      //             )
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // )
    );
  }
}
