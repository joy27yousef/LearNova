import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Orloginwith extends StatelessWidget {
  final String textin;
  const Orloginwith({super.key, required this.textin});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.5,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Text(
          " OR $textin With ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontFamily: AppFonts.Poppins,
            fontWeight: FontWeight.w300,
          ),
        ),
        Container(
          height: 1.5,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ],
    );
  }
}
