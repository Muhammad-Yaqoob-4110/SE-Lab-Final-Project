import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const CustomTextButton(
      {super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF4CBB9B);

    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          style:
              ButtonStyle(backgroundColor: MaterialStatePropertyAll(myColor))),
    );
  }
}
