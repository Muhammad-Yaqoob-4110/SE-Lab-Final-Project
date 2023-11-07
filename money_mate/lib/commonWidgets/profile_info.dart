import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  const ProfileInfo(
      {required this.text,
      this.fontSize = 16,
      this.textColor = Colors.black,
      this.fontWeight = FontWeight.normal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
