import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_nova/controller/auth/signupController.dart';
import 'package:learn_nova/core/constant/AppColor.dart';
import 'package:learn_nova/core/constant/AppFont.dart';

class Conditionsagree extends GetView<SignupControllerIMP> {
  const Conditionsagree({super.key});

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: controller.isChecked.value,
      validator: (value) {
        if (!controller.isChecked.value) {
          return 'You must accept the terms and conditions';
        }
        return null;
      },
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Transform.translate(
                  offset: Offset(-8, 0),
                  child: CheckboxListTile(
                    hoverColor: Appcolor.base,
                    contentPadding: EdgeInsets.zero,
                    title: Transform.translate(
                      offset: Offset(-10, 0),
                      child: Text(
                        "Agree to Terms & Conditions",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.Poppins,
                        ),
                      ),
                    ),
                    value: controller.isChecked.value,
                    onChanged: (val) {
                      controller.toggleCheckbox(val);
                      state.didChange(val);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 170, 0, 71),
                      fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
