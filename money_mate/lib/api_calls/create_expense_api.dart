import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> createExpense({
  required String apiUrl,
  required String description,
  required double amount,
  required String paidBy,
  required String group,
}) async {
  final data = {
    'description': description,
    'amount': amount,
    'paidBy': paidBy,
    'group': group,
  };

  final response = await http.post(Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data));

  final responseData = json.decode(response.body);
  return responseData;
}
