import 'package:flutter/material.dart';

class CustomButtonsRow extends StatefulWidget {
  final String leftButtonText;
  final String rightButtonText;
  final Color textColor;
  final Color textTabColor;
  final Function() onLeftButtonPressed;
  final Function() onRightButtonPressed;

  const CustomButtonsRow(
      {required this.leftButtonText,
      required this.rightButtonText,
      required this.textColor,
      required this.textTabColor,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed,
      super.key});

  @override
  _CustomButtonsRowState createState() => _CustomButtonsRowState();
}

class _CustomButtonsRowState extends State<CustomButtonsRow> {
  bool leftButtonClicked = true;
  bool rightButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                leftButtonClicked = true;
                rightButtonClicked = false;
              });
              widget.onLeftButtonPressed();
            },
            child: Text(
              widget.leftButtonText,
              style: TextStyle(
                color:
                    leftButtonClicked ? widget.textTabColor : widget.textColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                rightButtonClicked = true;
                leftButtonClicked = false;
              });
              widget.onRightButtonPressed();
            },
            child: Text(
              widget.rightButtonText,
              style: TextStyle(
                color:
                    rightButtonClicked ? widget.textTabColor : widget.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
