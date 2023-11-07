import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;
  final double borderRadius;
  final double padding;
  final EdgeInsets margin; // Add margin property
  final Color color;
  final double elevation;

  CustomContainer({
    required this.children,
    this.borderRadius = 5.0,
    this.padding = 16.0,
    this.margin = const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
    this.color = Colors.white,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      color: color,
      margin: margin, // Apply margin
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
