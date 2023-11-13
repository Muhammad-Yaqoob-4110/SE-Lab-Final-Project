import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final List<Widget> children;
  final double width; // Added width property
  final double borderRadius;
  final double padding;
  final EdgeInsets margin;
  final Color color;
  final double elevation;

  CustomContainer({
    required this.children,
    this.width = double.infinity, // Default width is set to infinity
    this.borderRadius = 5.0,
    this.padding = 16.0,
    this.margin = const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
    this.color = Colors.white,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        width: width, // Set the width
        margin: margin,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          color: color,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: SingleChildScrollView(
              // Wrap content in SingleChildScrollView
              child: Column(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
