import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:lottie/lottie.dart';

class Grades extends StatelessWidget {
  Grades({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseControllerIMP>(builder: (controller) {
      if (controller.statusrequest == Statusrequest.loading) {
        return Center(child: Lottie.asset(Appimages.loading2));
      }

      if (controller.statusrequest == Statusrequest.failure) {
        return Center(child: Text("❌ Failed to load data"));
      }
      final bool canTakeQuiz = controller.canTakeQuiz;

      int sequential = controller.data["is_sequential"];
      int reqprogress = sequential == 1 ? 100 : 80;

      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onTap: () {
                if (canTakeQuiz) {
                  Get.offAllNamed(
                    AppRoutes.quizPage,
                    arguments: {
                      'id': controller.idCourse,
                    },
                  );
                } else {
                  showCustomSnackbar(
                    title: 'You can not open the test',
                    message: "Watch all videos first",
                    backgroundColor: Colors.grey,
                    icon: Icons.error,
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border(
                    left: BorderSide(
                      color: canTakeQuiz ? Colors.orange : Colors.grey.shade700,
                      width: 7,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: canTakeQuiz
                              ? Colors.orange
                              : Colors.grey.shade700,
                          radius: 30,
                          child: Icon(
                            canTakeQuiz ? Icons.lock_open_rounded : Icons.lock,
                            color: canTakeQuiz
                                ? Colors.white
                                : Colors.grey.shade300,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          canTakeQuiz
                              ? 'Take Quiz'
                              : 'Complete ${reqprogress - controller.progress}% to unlock',
                          style: canTakeQuiz
                              ? Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 20)
                              : Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    if (canTakeQuiz) ...[
                      Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            controller.quizData['title'] ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 10),
                          Text(
                            controller.quizData['description'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                          ),
                          Row(
                            children: [
                              Icon(Icons.timer, color: Colors.orange),
                              SizedBox(width: 5),
                              Text(
                                "Time Limit: ${controller.quizData['time_limit'] ?? '-'}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.done_rounded, color: Colors.orange),
                          SizedBox(width: 5),
                          Text(
                            "Passing Score: ${controller.quizData['passing_score'] ?? '-'}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ] else ...[
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: controller.progress / 100,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            backgroundColor: Colors.grey[300],
                            color: Appcolor.base,
                            minHeight: 12,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${controller.progress} / $reqprogress completed',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 12),
                          )
                        ],
                      ),
                    ]
                  ], //
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
