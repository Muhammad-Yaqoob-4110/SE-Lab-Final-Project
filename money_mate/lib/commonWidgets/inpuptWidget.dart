import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final Color customColor;
  final Color appColor;

  CustomInputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    required this.customColor,
    required this.appColor,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: widget.customColor),
        ),
        labelStyle: TextStyle(
          color: widget.customColor,
        ),
        prefixIcon: Icon(widget.icon),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.customColor),
        ),
        prefixIconColor: widget.customColor,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: widget.customColor,
                ),
              )
            : null,
      ),
      obscureText: widget.isPassword ? _obscureText : false,
      controller: widget.controller,
    );
  }
}
