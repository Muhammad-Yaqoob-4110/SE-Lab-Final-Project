import 'package:flutter/material.dart';

class CustomLinkWidget extends StatelessWidget {
  final String text;
  final Color customColor;
  final Function onTap;

  CustomLinkWidget({
    required this.text,
    required this.customColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: customColor,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
