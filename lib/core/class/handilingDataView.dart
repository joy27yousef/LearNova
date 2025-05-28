import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:lottie/lottie.dart';
import 'package:learn_nova/core/class/statusRequest.dart';

class Handilingdataview extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  const Handilingdataview(
      {super.key, required this.statusrequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusrequest == Statusrequest.loading
        ? Center(child:Lottie.asset(Appimages.loading) )
        : statusrequest == Statusrequest.offlinefailure
            ? Center(child: Text('offline'))
            : statusrequest == Statusrequest.serverfailure
                ? Center(child: Text('server failure'))
                : statusrequest == Statusrequest.failure
                    ? Center(child: Text('No data'))
                    : widget;
  }
}
