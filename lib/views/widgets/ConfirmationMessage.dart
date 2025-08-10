import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showRegisterConfirmation(BuildContext context, VoidCallback onConfirm,
    String title, String desc, String cancel, String confirm) {
  AwesomeDialog(
    
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.scale,
    title: title,
    desc: desc,
    btnCancelText: cancel,
    btnCancelOnPress: () {},
    btnOkText: confirm,
    btnOkOnPress: onConfirm,
    btnOkColor: Colors.green,
  ).show();
}
