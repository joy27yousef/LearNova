import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class TextFormGen extends StatelessWidget {
  final String hint;
  final String lable;
  final Icon iconform;
  final TextEditingController mycontroller;
  final TextInputType typekey;
  final String? Function(String?) valid;
  final bool? obscureText;
  final void Function()? onTapicon;

  const TextFormGen(
      {super.key,
      required this.hint,
      required this.lable,
      required this.iconform,
      required this.mycontroller,
      required this.typekey,
      required this.valid,
      this.obscureText,
      this.onTapicon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: typekey,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: mycontroller,
      obscureText: obscureText == null || obscureText == false ? false : true,
      validator: valid,
      cursorColor: Appcolor.base,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 170, 0, 71),
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        hintText: hint,
        hintStyle:
            TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w400),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          onTap: onTapicon,
          child: iconform,
        ),
        focusColor: Appcolor.baselight,
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        // const Color.fromARGB(255, 250, 249, 255),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 3),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Appcolor.baselight, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Appcolor.baselight, width: 2),
        ),
        label: Container(
          margin: EdgeInsets.all(10),
          child: Text(
            lable,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500,
                fontFamily: AppFonts.Poppins),
          ),
        ),
      ),
    );
  }
}
