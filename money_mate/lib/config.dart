import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = "http://localhost:4110/api";
  static const String loginUserApi = "$baseUrl/users/login";
  static const String signUpApi = "$baseUrl/users";
  static const String updateUserApi = "$baseUrl/users";
  static const String createGroupApi = "$baseUrl/create-group";
  static const String getAllGroupsByEmailApi = "$baseUrl/groups";
  static const String getGroupsByToken = "$baseUrl/groups";
  static const String addMemberToGroupApi = "$baseUrl/add-member";
  static const String getAllExpensesList = "$baseUrl/all-expense";
  static const String createExpenseApi = "$baseUrl/create-expense";
}

class AppThemes {
  static ThemeData theme = ThemeData(
    // final Color customColor/primary = const Color(0xFF666666);
    // final Color appColor/secondary = const Color(0xFF64C9AC);

    primaryColor: const Color(0xFF666666),
    secondaryHeaderColor: const Color(0xFF64C9AC),
  );
}
