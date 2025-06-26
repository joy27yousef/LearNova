import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

class CourseReviews extends StatelessWidget {
  const CourseReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(Appimages.person),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('name of person'),
          Container(
            height: 25,
            width: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Appcolor.base, width: 1.5),
                color: const Color.fromARGB(255, 230, 224, 255),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Appimages.rating,
                  width: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  '5',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          )
        ],
      ),
      subtitle: Text('The course materials are top-notch and well organized.'),
    );
  }
}
