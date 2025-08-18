import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/controller/myCourses/resultsController.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/openCertificateUrl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultsController>(
      builder: (controller) {
        if (controller.statusrequest == Statusrequest.loading) {
          return Scaffold(
            body: Center(child: Lottie.asset(Appimages.loading2)),
          );
        }

        if (controller.statusrequest == Statusrequest.failure) {
          return Scaffold(
            body: Center(child: Text("❌ Failed to load results")),
          );
        }

        final resultData = controller.resultsdata;
        final quizData = controller.quizdata;

        final String quiztitle = quizData['title'] ?? 'title';
        final String quizdescription = quizData['description'] ?? 'description';
        final int score = int.tryParse("${resultData['score'] ?? 0}") ?? 0;
        final int correctAnswers =
            int.tryParse("${resultData['correct_answers'] ?? 0}") ?? 0;
        final int totalQuestions =
            int.tryParse("${resultData['total_questions'] ?? 0}") ?? 0;

        final List analysis = resultData['answer_analysis'];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Results'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(controller.isdark
                      ? Appimages.graduationdark
                      : Appimages.graduation),
                ),
                Text(
                  'Congratulations\non completing the course',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: const Border(
                      left: BorderSide(
                        color: Appcolor.base,
                        width: 7,
                      ),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                    children: [
                      Text(
                        quiztitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        quizdescription,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: Colors.green, size: 15),
                          const SizedBox(width: 10),
                          Text(
                            'Your Score: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "$score%",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.circle,
                              color: Colors.green, size: 15),
                          const SizedBox(width: 10),
                          Text(
                            'Correct Answers: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "$correctAnswers/$totalQuestions",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text('Certification',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    openUrl(controller.url);
                  },
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(color: Appcolor.base, width: 7),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🎉 Congratulations',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 17)),
                        const SizedBox(height: 15),
                        Text(
                          score > 70
                              ? 'Based on your average, you have received a recognized certificate'
                              : 'Based on your average, you got a certificate of attendance',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox.shrink(),
                            Text(
                              'Click to watch',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text('Question Review',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: analysis.length,
                  itemBuilder: (context, index) {
                    final item = analysis[index];
                    final questionText = item['question_text'] ?? '';
                    final userAnswer = item['user_answer'];
                    final correctAnswer = item['correct_answer'];
                    final int? selectedOptionId = userAnswer?['option_id'];
                    final bool isCorrect = userAnswer?['is_correct'] == 1;
                    final List options = item['all_options'];

                    final selectedText = options.firstWhere(
                      (opt) => opt['id'] == selectedOptionId,
                      orElse: () => {'text': 'لم يتم الإجابة'},
                    )['text'];

                    final int? correctOptionId = correctAnswer?['option_id'];
                    final String correctText = options.firstWhere(
                      (opt) => opt['id'] == correctOptionId,
                      orElse: () => {'text': 'غير معروف'},
                    )['text'];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.background,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          questionText,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              "Your answer: $selectedText",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                            ),
                            const SizedBox(height: 5),
                            Text("The correct answer: $correctText"),
                          ],
                        ),
                        trailing: Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
