import 'package:flutter/material.dart';

class CustomHeading extends StatelessWidget {
  final String headingtitle;
  const CustomHeading({super.key, required this.headingtitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      headingtitle,
      style: const TextStyle(
          fontFamily: 'Gotham', fontSize: 50, color: Colors.white),
    );
  }
}
