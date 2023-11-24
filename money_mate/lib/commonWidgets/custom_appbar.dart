import 'package:flutter/material.dart';
import 'package:money_mate/config.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
  final Color customColor = AppThemes.theme.primaryColor;
  final Color appColor = AppThemes.theme.secondaryHeaderColor;

  CustomAppBar({required this.title, this.onBackButtonPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: customColor,
      child: Row(
        children: [
          if (onBackButtonPressed != null)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBackButtonPressed,
            ),
          if (onBackButtonPressed != null) const SizedBox(width: 8.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
