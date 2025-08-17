import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';
import 'package:learn_nova/core/function/validinput.dart';
import 'package:learn_nova/views/widgets/boxText.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/actionRatingAppBar.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/reviewForm.dart';

class AddRatingPage extends StatelessWidget {
  final RatingController controller = Get.find();
  AddRatingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Get.back();
                Get.back();
              }),
          title: Text('Rate your experience'),
          centerTitle: true,
          actions: [
            const ActionRatingAppBar(),
          ],
        ),
        body: Form(
          key: controller.formstate,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(
                  "We highly value feedback! Kindly take a moment to rate youre experience and provide us with youre valuble feedback in the course.",
                  textAlign: TextAlign.justify,
                  textScaleFactor: 0.9,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 17),
                ),
                SizedBox(height: 20),
                Center(
                  child: RatingBar.builder(
                    itemSize: 50,
                    glowColor: Colors.yellow.shade400,
                    unratedColor: Colors.grey.shade200,
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 3),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow.shade600,
                    ),
                    onRatingUpdate: (rating) {
                      controller.ratingNum = rating;
                    },
                  ),
                ),
                SizedBox(height: 20),
                ReviewForm(
                  hint: 'rate your experience',
                  mycontroller: controller.review,
                  typekey: TextInputType.text,
                  valid: (val) => validInput(val!, 1, 1000, 'name'),
                ),
                SizedBox(height: 50),
                Boxtext(
                  textin: 'Send',
                  onTapFun: () {
                    controller.addUserRating();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
