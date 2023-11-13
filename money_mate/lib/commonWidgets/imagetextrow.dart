import 'package:flutter/material.dart';

class ImageTextRow extends StatelessWidget {
  final String imagePath;
  final double imageHeight;
  final double imageWidth;
  final String text;
  final Color textColor;
  final double fontSize;

  const ImageTextRow(
      {required this.imagePath,
      required this.imageHeight,
      required this.imageWidth,
      required this.text,
      required this.textColor,
      required this.fontSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              imagePath,
              height: imageHeight,
              width: imageWidth,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
