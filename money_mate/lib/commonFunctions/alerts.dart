import 'package:flutter/material.dart';
import 'package:money_mate/commonWidgets/alert_widget.dart';

void showCustomAlert(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomAlertDialog(
        title: title,
        message: message,
        buttonText: "OK",
        onButtonPressed: () {},
      );
    },
  );
}

void showCustomNameAlert(BuildContext context) {
  showCustomAlert(context, "Alert", "Your full name is required to continue.");
}

void showDescriptionAlert(BuildContext context) {
  showCustomAlert(
      context, "Alert", "Short Description is required to continue.");
}

void showCustomGroupNameAlert(BuildContext context) {
  showCustomAlert(context, "Alert", "Group name is required to continue.");
}

void showCustomEmailAlert(BuildContext context) {
  showCustomAlert(context, "Alert", "Double-check your email for any typos.");
}

void showCustomPaswordAlert(BuildContext context) {
  showCustomAlert(context, "Alert",
      "Make your password stronger by adding numbers and symbols.");
}

void showAmountAlert(BuildContext context) {
  showCustomAlert(context, "Alert",
      "Please make sure to enter a positive whole number for the amount.");
}

void showCustomPhoneAlert(BuildContext context) {
  showCustomAlert(
      context, "Alert", "Double-check your phone number format 03XXXXXXXXX.");
}

void showCustomApiResponce(BuildContext context, String message) {
  showCustomAlert(context, "Api Responce", message);
}

void showCustomErrorOccured(BuildContext context, String message) {
  showCustomAlert(context, "Error Occurred", message);
}

bool isValidEmail(String email) {
  RegExp emailPattern = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailPattern.hasMatch(email);
}

bool isValidPhoneNumber(String input) {
  RegExp phoneNumberPattern = RegExp(r'^\d{11}$');
  return phoneNumberPattern.hasMatch(input);
}

bool containsOnlyNumbers(String input) {
  final RegExp regex = RegExp(r'^[0-9]+$');
  return regex.hasMatch(input);
}
