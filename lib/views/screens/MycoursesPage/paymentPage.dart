import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/controller/myCourses/myCoursesController.dart';
import 'package:learn_nova/controller/userController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/core/function/confirmationAlert.dart';
import 'package:learn_nova/views/widgets/boxText.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});
  int id = Get.arguments['id'];
  String title = Get.arguments['title'];
  String image = Get.arguments['image'];
  String price = Get.arguments['price'];
  String duration = Get.arguments['duration'];
  String difficulty_level = Get.arguments['difficulty_level'];
  final List<String> titleScroll = ['Syriatel Cash', 'MTN Cash'];
  final List mtn = [
    "Open the 'MTN Cash' app",
    "Enter your password",
    "Enter your phone number",
    "Enter the required amount"
  ];
  final List syriatel = [
    "Open the 'Aqrab Elik' app",
    "Go to Syriatel Cash and enter your password",
    "Enter your phone number",
    "Enter the required amount"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PaymentPage'),
        ),
        body: Column(
          children: [
            Container(
              height: 130,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 17),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Level: $difficulty_level',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Duration: $duration',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              'price:',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.normal),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ' $price SPY',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.green),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        tabBarTheme: const TabBarTheme(
                          dividerColor: Colors.transparent,
                        ),
                      ),
                      child: TabBar(
                        indicatorColor: Appcolor.base,
                        labelColor: Appcolor.base,
                        unselectedLabelColor: Colors.grey,
                        indicatorWeight: 3,
                        tabs: List.generate(
                          titleScroll.length,
                          (i) => Tab(
                            child: Text(
                              titleScroll[i],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage(Appimages.syriatel),
                                ),
                                const SizedBox(height: 20),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: syriatel.length,
                                  itemBuilder: (context, i) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${i + 1}.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            syriatel[i],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(Appimages.mtn),
                                ),
                                const SizedBox(height: 20),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: mtn.length,
                                  itemBuilder: (context, i) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${i + 1}.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            mtn[i],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Boxtext(
                  textin: 'Complete Payment- $price SPY',
                  onTapFun: () async {
                    confirmationAelrt(
                        Appimages.enroll,
                        'Would you really like to enroll in this course ??',
                        "No, I don't want",
                        'Yes, Enroll',
                        Appcolor.base, () async {
                      Get.find<CourseControllerIMP>().enroll();
                      await Get.find<MyCoursesControllerIMP>().getMyCourses(
                          Get.find<UserControllerIMP>().user['id']);
                      Get.find<CourseControllerIMP>().checkEnrollment();
                    });
                  }),
            )
          ],
        ));
  }
}
