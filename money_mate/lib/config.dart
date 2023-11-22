import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = "http://localhost:4110/api";
  static const String loginUserApi = "$baseUrl/users/login";
  static const String signUpApi = "$baseUrl/users";
  static const String updateUserApi = "$baseUrl/users";
  static const String createGroupApi = "$baseUrl/create-group";
}

class AppThemes {
  static ThemeData theme = ThemeData(
    // final Color customColor/primary = const Color(0xFF666666);
    // final Color appColor/secondary = const Color(0xFF64C9AC);

    primaryColor: const Color(0xFF666666),
    secondaryHeaderColor: const Color(0xFF64C9AC),
  );
}
