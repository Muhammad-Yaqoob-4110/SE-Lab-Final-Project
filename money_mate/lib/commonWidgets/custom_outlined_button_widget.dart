import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fixedSizeWidth;
  final double fixedSizeHeight;

  CustomOutlinedButton({
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.fixedSizeHeight,
    required this.fixedSizeWidth,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(fixedSizeWidth, fixedSizeHeight),
        backgroundColor: backgroundColor,
        shadowColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
