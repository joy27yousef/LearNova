import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/data/source/static.dart';

class Benefitsgen extends StatelessWidget {
  final int? x;
  final double? y;
  final ScrollPhysics? physics;
  const Benefitsgen(
      {super.key, required this.x, this.physics, required this.y});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: physics,
        itemCount: x,
        itemBuilder: (contex, i) => Card(
              margin: EdgeInsets.all(y!),
              elevation: 3,
              color: Colors.white,
              child: ListTile(
                trailing: Image.asset(Benefits[i].icon!),
                subtitle: Text(
                  Benefits[i].content!,
                  style: TextStyle(fontFamily: AppFonts.Poppins),
                ),
                title: Text(
                  Benefits[i].titl!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: AppFonts.Poppins),
                ),
              ),
            ));
  }
}
