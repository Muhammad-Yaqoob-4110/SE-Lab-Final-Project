import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> createGroupApiCall(
    {required String apiUrl,
    required String groupName,
    required String creatorEmail}) async {
  final data = {
    "name": groupName,
    "creator": creatorEmail,
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
