import 'package:flutter/material.dart';
class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100,
      right: -100,
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 239, 255),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
