import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/myCourses/quizController.dart';

import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

import 'package:learn_nova/core/function/alertExitApp.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:lottie/lottie.dart';

class QuizPage extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    controller.initController(context);
    return WillPopScope(
      onWillPop: () => alerExitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Test yourself',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.timer_1,
                          color: Appcolor.base,
                          weight: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          controller
                              .formatTime(controller.timeLeftSeconds.value),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: Lottie.asset(Appimages.loading2));
          }

          if (controller.questions.isEmpty) {
            return Center(child: Text("لا توجد أسئلة"));
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: LinearProgressIndicator(
                  value: (controller.currentPage.value + 1) /
                      controller.questions.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  backgroundColor: Colors.grey[300],
                  color: Appcolor.base,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                  },
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    final question = controller.questions[index];
                    final options = question['options'] as List<dynamic>;

                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("The question ${index + 1}:",
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: 20),
                          Text(question['question_text'] ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                          SizedBox(height: 20),
                          ...options.map((option) {
                            int optionId = option['id'];
                            return Obx(() {
                              bool isSelected =
                                  controller.selectedAnswers[index] == optionId;
                              return ListTile(
                                minVerticalPadding: 15,
                                title: Text(option['option_text'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17)),
                                leading: Radio<int>(
                                  activeColor: Appcolor.base,
                                  value: optionId,
                                  groupValue: controller.selectedAnswers[index],
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectAnswer(index, value);
                                    }
                                  },
                                ),
                                tileColor: isSelected
                                    ? Colors.grey.withOpacity(0.2)
                                    : null,
                              );
                            });
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: [
                    // زر الرجوع (يسار)
                    if (controller.currentPage.value > 0)
                      SizedBox(
                        width: 90,
                        child: InkWell(
                          onTap: () {
                            controller.currentPage.value--;
                            controller.pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).colorScheme.background,
                            ),
                            child: Center(
                              child: Text('Previous',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 17)),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                          width: 90), // مساحة فارغة لما ما يكون فيه زر رجوع

                    Spacer(), // يفصل بين الزرين ويدفع التالي لليمين

                    // زر التالي/إرسال (يمين)
                    SizedBox(
                      width: 90,
                      child: Boxtext(
                        textin: controller.currentPage.value ==
                                controller.questions.length - 1
                            ? "Submit"
                            : "Next",
                        onTapFun: () {
                          if (controller.currentPage.value ==
                              controller.questions.length - 1) {
                            confirmationAelrt(
                          
                              Appimages.submit,
                              'Are you sure you want to send the test ?? You can never take it back',
                              'No, go back',
                              'Submit',
                              Colors.green,
                              () {
                                controller.submitAnswers();
                              },
                            );
                          } else {
                            controller.nextQuestion();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
