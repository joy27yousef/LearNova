import 'package:flutter/material.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:lottie/lottie.dart';
import 'package:learn_nova/core/class/statusRequest.dart';

class Handilingdataview extends StatelessWidget {
  final List<Statusrequest> statusrequests;
  final Widget widget;

  const Handilingdataview({
    super.key,
    required this.statusrequests,
    required this.widget,
  });

  bool _allSuccess() {
    return statusrequests.every((status) => status == Statusrequest.success);
  }

  Statusrequest _firstNonSuccess() {
    return statusrequests.firstWhere(
      (status) => status != Statusrequest.success,
      orElse: () => Statusrequest.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_allSuccess()) {
      return widget;
    }

    final currentStatus = _firstNonSuccess();

    switch (currentStatus) {
      case Statusrequest.loading:
        return Center(child: Lottie.asset(Appimages.loading2));
      case Statusrequest.offlinefailure:
        return Center(child: Lottie.asset(Appimages.offline));
      case Statusrequest.serverfailure:
        return Center(child: const Text('Server failure'));
      case Statusrequest.failure:
        return Center(child: const Text('No data'));
      default:
        return widget;
    }
  }
}
