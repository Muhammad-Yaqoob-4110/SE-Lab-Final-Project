import 'package:flutter/material.dart';

class CustomFlatWButtonWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  CustomFlatWButtonWithText(
      {required this.icon,
      required this.text,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Button background color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
