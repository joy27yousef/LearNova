import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/home/courseController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

class CourseReviews extends StatelessWidget {
  CourseReviews({super.key});
  List ratings = Get.find<CourseControllerIMP>().data['ratings'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, i) => ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(Appimages.person),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${ratings[i]['user']['first_name']} ${ratings[i]['user']['last_name']}'),
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
                            '${ratings[i]['rating']}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Appcolor.base),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                subtitle: Text(
                  '${ratings[i]['review'] ?? 'There is no review'}',
                  softWrap: true,
                  overflow: TextOverflow.clip,
                ),
              )),
    );
  }
}
