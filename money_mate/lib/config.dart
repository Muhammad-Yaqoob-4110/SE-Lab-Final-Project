import 'package:flutter/material.dart';

class ApiConstants {
  static const String baseUrl = "http://138.68.108.189/api";
  // static const String baseUrl = "http://127.0.0.1:4110/api";
  static const String loginUserApi = "$baseUrl/users/login";
  static const String signUpApi = "$baseUrl/users";
  static const String updateUserApi = "$baseUrl/users";
  static const String createGroupApi = "$baseUrl/groups";
  static const String getAllGroupsByEmailApi = "$baseUrl/groups";
  static const String getGroupsByToken = "$baseUrl/groups";
  static const String addMemberToGroupApi = "$baseUrl/groups";
  static const String getAllExpensesList = "$baseUrl/expenses";
  static const String createExpenseApi = "$baseUrl/expenses";
  static const String allFriendsApi = "$baseUrl/friends";
  static const String addFriendApi = "$baseUrl/friends";
}

class AppThemes {
  static ThemeData theme = ThemeData(
    // final Color customColor/primary = const Color(0xFF666666);
    // final Color appColor/secondary = const Color(0xFF64C9AC);

    primaryColor: const Color(0xFF666666),
    secondaryHeaderColor: const Color(0xFF64C9AC),
  );
}
