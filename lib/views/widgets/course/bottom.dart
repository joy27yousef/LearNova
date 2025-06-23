import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.only(left: 8, bottom: 10, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 45,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Appcolor.base, width: 2),
                color: Theme.of(context).colorScheme.background,
              ),
              child: Center(
                child: Text(
                  "7\$",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Appcolor.base),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Appcolor.base),
                child: Center(
                  child: Text(
                    "Enroll Now",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
