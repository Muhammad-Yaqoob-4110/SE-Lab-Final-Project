import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;

  const CustomPasswordTextField(
      {super.key, required this.controller, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter password';
          }
          // Add any additional password validation rules if needed
          return null;
        },
        decoration: InputDecoration(
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(6)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
