import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
class Textinlogsingin extends StatelessWidget {
  final String text1;
  final String text2;
  const Textinlogsingin({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: text1,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Appcolor.base, fontSize: 30, fontWeight: FontWeight.bold)),
      TextSpan(
          text: text2,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w400))
    ]));
  }
}
