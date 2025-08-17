import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/controller/ThemeModeController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class TextformAuth extends StatelessWidget {
  final String hint;
  final String lable;
  final Icon iconform;
  final TextEditingController mycontroller;
  final TextInputType typekey;
  final String? Function(String?) valid;
  final bool obscureText; // ✅ أصبح غير nullable
  final void Function()? onTapicon;
  final Color? color;

  const TextformAuth({
    super.key,
    required this.hint,
    required this.lable,
    required this.iconform,
    required this.mycontroller,
    required this.typekey,
    required this.valid,
    this.obscureText = false, // ✅ قيمة افتراضية
    this.onTapicon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    return TextFormField(
      keyboardType: typekey,

      autofocus: false,
      style: Theme.of(context).textTheme.bodySmall,
      controller: mycontroller,
      obscureText: obscureText, // ✅ لا حاجة للفحص
      validator: valid,
      cursorColor: Appcolor.base,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 170, 0, 71),
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
          fontSize: 15,
        ),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onTapicon,
          child: iconform,
        ),
        focusColor: Appcolor.base,
        filled: true,
        fillColor: Get.find<ThemeController>().isDarkMode.value
            ? Theme.of(context).colorScheme.background
            : const Color.fromARGB(255, 250, 249, 255),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.baselight, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.base, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.base, width: 2),
        ),
        label: Container(
          margin: EdgeInsets.all(10),
          child: Text(
            lable,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
