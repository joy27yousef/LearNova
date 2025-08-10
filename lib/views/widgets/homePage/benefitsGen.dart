import 'package:flutter/material.dart';
import 'package:learn_nova/core/class/animatedListItem.dart';
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
        itemBuilder: (contex, i) => AnimatedListItem(
              child: Card(
                margin: EdgeInsets.all(y!),
                elevation: 3,
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  trailing: Image.asset(Benefits[i].icon!),
                  subtitle: Text(
                    Benefits[i].content!,
                    style: Theme.of(contex).textTheme.bodySmall,
                    textAlign: TextAlign.start,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 8),
                    child: Text(Benefits[i].titl!,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
              ),
            ));
  }
}
