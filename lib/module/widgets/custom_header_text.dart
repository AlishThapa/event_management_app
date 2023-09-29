import 'package:flutter/material.dart';

class CustomHeaderText extends StatelessWidget {
  const CustomHeaderText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.teal,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
    ;
  }
}
