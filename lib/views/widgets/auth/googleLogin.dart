import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppImages.dart';

class Googlelogin extends StatelessWidget {
  const Googlelogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 300,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey.shade400)],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).colorScheme.background),
        child: Image.asset(Appimages.googleLogo, width: 50),
      ),
    );
  }
}
