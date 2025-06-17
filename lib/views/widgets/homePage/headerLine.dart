import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Headerline extends StatelessWidget {
  final String hint1;
  final String hint2;
  final void Function()? onTapHeader;
  const Headerline(
      {super.key,
      required this.hint1,
      required this.hint2,
      required this.onTapHeader});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint1,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: onTapHeader,
            child: Text(
              hint2,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
