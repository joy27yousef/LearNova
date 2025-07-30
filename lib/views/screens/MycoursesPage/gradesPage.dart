import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/quizController.dart';
import 'package:learn_nova/core/class/handilingDataView.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/function/customSnackBar.dart';
import 'package:lottie/lottie.dart';

class Grades extends StatelessWidget {
  Grades({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(QuizController());
    return FutureBuilder<bool>(
      future: controller.canGetQuiz(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Lottie.asset(Appimages.loading2));
        }
        final bool canTakeQuiz = snapshot.data!;
        return ListView(
          children: [
            GetBuilder<QuizController>(builder: (controller) {
              return Flexible(
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  onTap: () {
                    if (canTakeQuiz) {
                      Get.toNamed(AppRoutes.quizPage);
                    } else {
                      showCustomSnackbar(
                          title: 'You can not open the test',
                          message: "Watch all videos first",
                          backgroundColor: Colors.grey,
                          icon: Icons.error);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border(
                        left: BorderSide(
                          color: canTakeQuiz
                              ? Colors.orange
                              : Colors.grey.shade700,
                          width: 7,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: canTakeQuiz
                                    ? Colors.orange
                                    : Colors.grey.shade700,
                                radius: 30,
                                child: Icon(
                                  canTakeQuiz
                                      ? Icons.lock_open_rounded
                                      : Icons.lock,
                                  color: canTakeQuiz
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              canTakeQuiz
                                  ? 'Take Quiz'
                                  : 'Complete ${100 - controller.progress}% to unlock',
                              style: canTakeQuiz
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 20)
                                  : Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          controller.quizData[0]['title'],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.quizData[0]['description'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                            children: canTakeQuiz
                                ? [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.orange,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          canTakeQuiz
                                              ? "Time Limit: ${controller.quizData[0]['time_limit']}"
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.done_rounded,
                                          color: Colors.orange,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          canTakeQuiz
                                              ? "Passing Score: ${controller.quizData[0]['passing_score']}"
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ]
                                : [])
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        );
      },
    );
  }
}
