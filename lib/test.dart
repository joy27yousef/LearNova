import 'package:flutter/material.dart';
import 'package:learn_nova/core/function/ckeckInternet.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var res;
  initialdata() async {
    res = await checkInternet();
    print(res);
  }

  @override
  void initState() {
    initialdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('test'),
      ),
    );
  }
}
