import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppColor.dart';

class ReviewForm extends StatelessWidget {
  final String hint;

  final TextEditingController mycontroller;
  final TextInputType typekey;
  final String? Function(String?) valid;
  final bool? obscureText;
  final void Function()? onTapicon;

  const ReviewForm({
    super.key,
    required this.hint,
    required this.mycontroller,
    required this.typekey,
    required this.valid,
    this.obscureText,
    this.onTapicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      obscureText: obscureText ?? false,
      validator: valid,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 5,
      cursorColor: Appcolor.base,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.grey[500],
            ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.baselight3, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.baselight, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Appcolor.baselight, width: 2),
        ),
      ),
    );
  }
}
