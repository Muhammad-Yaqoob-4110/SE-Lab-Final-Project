import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> createGroupApiCall({
  required String apiUrl,
  required String groupName,
  required String bearerToken,
}) async {
  final data = {
    "name": groupName,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: json.encode(data),
  );

  final responseData = json.decode(response.body);
  return responseData;
}
