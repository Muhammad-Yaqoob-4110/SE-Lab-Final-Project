import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponse {
  final String message;
  final List<Expense> expenses;

  ApiResponse({
    required this.message,
    required this.expenses,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'] ?? '',
      expenses: (json['expenses'] as List<dynamic>?)
              ?.map((expense) => Expense.fromJson(expense))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'ApiResponse{message: $message, expenses: $expenses}';
  }
}

class Expense {
  final String id;
  final String description;
  final double amount;
  final String paidBy;
  final String group;
  final String date;
  final String createdAt;
  final String updatedAt;
  final int v;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.group,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'] ?? '',
      description: json['description'] ?? '',
      amount: json['amount']?.toDouble() ?? 0.0,
      paidBy: json['paidBy'] ?? '',
      group: json['group'] ?? '',
      date: json['date'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'description': description,
      'amount': amount,
      'paidBy': paidBy,
      'group': group,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

Future<ApiResponse> getExpensesApi({
  required String apiUrl,
}) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
  );

  final dynamic responseData = json.decode(response.body);

  if (responseData is Map<String, dynamic>) {
    return ApiResponse.fromJson(responseData);
  } else {
    // Handle the case where responseData is not a Map
    print('Unexpected response format');
    return ApiResponse(message: '', expenses: []);
  }
}
