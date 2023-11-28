import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  // final bool isValidator;
  // final String? validatorMessage;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    // required this.validatorMessage,
    // this.isValidator = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        // validator: (input) {
        //   if (input!.isEmpty) {
        //     if (isValidator) {
        //       return validatorMessage ?? "";
        //     }
        //   }
        //   return null;
        // },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email';
          }
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            hintText: hinttext,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(6)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            contentPadding: EdgeInsets.all(10),
            enabled: true),
      ),
    );
  }
}
