import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/data/source/static.dart';

class FAQHomePage extends StatelessWidget {
  FAQHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: fAQHomePage.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                collapsedBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                iconColor: Appcolor.base,
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                title: Text(
                  fAQHomePage[index].question!,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                      ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      fAQHomePage[index].answer!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
