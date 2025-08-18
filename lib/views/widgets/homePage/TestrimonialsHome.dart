import 'package:flutter/material.dart';
import 'package:learn_nova/core/class/animatedListItem.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';
import 'package:learn_nova/data/source/static.dart';

class Testrimonialshome extends StatelessWidget {
  const Testrimonialshome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: Testimonials.length,
        itemBuilder: (context, i) => AnimatedListItem(
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 4,
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    Testimonials[i].name!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Poppins,
                    ),
                  ),
                  subtitle: Text(
                    Testimonials[i].job!,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFonts.Poppins,
                    ),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Appcolor.base,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(Testimonials[i].image!),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Text(
                    Testimonials[i].story!,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
