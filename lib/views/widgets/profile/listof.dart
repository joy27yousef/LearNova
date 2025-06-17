import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Listof extends StatelessWidget {
  final bool? lan;
  final bool? darkmode;
  final String? title;
  final IconData? icon1;
  final IconData? icon2;
  final void Function()? onTap;
  final String? languageApp;
  const Listof(
      {super.key,
      required this.title,
      required this.icon1,
      this.icon2,
      this.lan,
      this.darkmode,
      this.languageApp,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      leading: Icon(
        icon1,
        size: 25,
      ),
      trailing: (lan == true)
          ? InkWell(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onTap: onTap,
              child: Text(
                languageApp!,
                style: TextStyle(
                    color: Appcolor.base,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Poppins),
              ),
            )
          : InkWell(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onTap: onTap,
              child: Icon(
                icon2,
                size: 30,
              ),
            ),
    );
  }
}
