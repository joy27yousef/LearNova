import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Listtileinfo extends StatelessWidget {
  final String title;
  final String image;
  const Listtileinfo({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LottieBuilder.asset(
          image,
          width: 35,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
