import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/myCourses/ratingController.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/actionRatingAppBar.dart';

class ViewRatingPage extends StatelessWidget {
  final RatingController controller = Get.find();
  ViewRatingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
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
          title: Text('Your rating'),
          centerTitle: true,
          actions: [
            const ActionRatingAppBar(),
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(controller.courseImage),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            Text(
              controller.courseTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer,
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${controller.userRating[0]['rating']}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 40),
                      ),
                      Icon(
                        Icons.star_purple500_sharp,
                        color: Colors.yellow.shade600,
                        size: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.justify,
                      textScaleFactor: 0.9,
                      controller.userRating[0]['review'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Thank you!',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
