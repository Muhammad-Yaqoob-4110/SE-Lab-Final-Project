import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> createExpenseApiCall({
  required String apiUrl,
  required String description,
  required int amount,
  required String paidById,
  required String groupId,
}) async {
  final data = {
    "description": description,
    "amount": amount,
    "paidBy": paidById,
    "group": groupId
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(data),
  );

  final responseData = json.decode(response.body);
  return responseData;
}
