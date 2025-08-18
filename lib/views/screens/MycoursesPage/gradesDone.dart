import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/quizController.dart';
import 'package:learn_nova/controller/myCourses/resultsController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/widgets/mycourses/courseLearn/document.dart';
import 'package:lottie/lottie.dart';

class GradesDone extends StatelessWidget {
  GradesDone({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizController());
    return GetBuilder<CourseControllerIMP>(builder: (controller) {
      if (controller.statusrequest == Statusrequest.loading) {
        return Center(child: Lottie.asset(Appimages.loading2));
      }

      if (controller.statusrequest == Statusrequest.failure) {
        return Center(child: Text("❌ Failed to load data"));
      }
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'Quizzes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onTap: () {
                Get.put(ResultsController());
                Get.toNamed(AppRoutes.resultsPage);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border(
                    left: BorderSide(
                      color: Colors.green,
                      width: 7,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 25,
                          child: Icon(
                            Icons.done,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Successfully completed',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 18))
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Your Score:  ',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "${controller.checkdata['latest_attempt']['score']}%",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      controller.quizData['title'] ?? 'No Title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 10),
                    Text(
                      controller.quizData['description'] ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'documents',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Documents()
        ],
      );
    });
  }
}
