import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class TextformAuth extends StatelessWidget {
  final String hint;
  final String lable;
  final Icon iconform;
  final TextEditingController mycontroller;
  final TextInputType typekey;
  final String? Function(String?) valid;
  final bool? obscureText;
  final void Function()? onTapicon;

  const TextformAuth(
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
      autofocus: false,
      style: Theme.of(context).textTheme.bodySmall,
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
        hintStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 15),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: onTapicon,
          child: iconform,
        ),
        focusColor: Appcolor.base,
        filled: true,
        fillColor: const Color.fromARGB(255, 250, 249, 255),
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
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
