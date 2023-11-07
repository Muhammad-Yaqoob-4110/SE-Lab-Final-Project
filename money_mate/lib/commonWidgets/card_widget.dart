import 'package:flutter/material.dart';

class CustomOptionCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;
  final Color cardColor;
  final Color textColor;

  CustomOptionCard({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Row(
          children: [
            Icon(icon, size: 20, color: textColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, size: 20, color: textColor),
        onTap: onTap,
      ),
    );
  }
}
