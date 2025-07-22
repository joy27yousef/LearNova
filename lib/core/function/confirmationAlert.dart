import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future confirmationAelrt(BuildContext context, image, String content,
    String cancel, String confirmation, Color color, Function()? onTap) {
  Get.defaultDialog(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: '',
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          image,
          height: 80,
        ),
        SizedBox(height: 50),
        Text(content,
        softWrap: true,
        overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 30),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: onTap,
              child: Flexible(
                child: Container(
                  height: 40,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(confirmation,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Text(cancel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: color, fontSize: 17)),
            ),
          ],
        ),
      ],
    ),
  );

  return Future.value(true);
}
