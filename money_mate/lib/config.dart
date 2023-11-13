import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = "http://localhost:4110/api";
  static const String loginUserApi = "$baseUrl/users/login";
  static const String signUpApi = "$baseUrl/users";
  static const String updateUserApi = "$baseUrl/users";
}

class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: Color.fromARGB(255, 219, 103, 103),
    secondaryHeaderColor: Color.fromARGB(255, 128, 141, 134),
  );
}
