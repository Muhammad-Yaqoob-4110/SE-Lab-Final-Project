import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> addFriendApiCall({
  required String apiUrl,
  required String bearerToken,
}) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
  );

  final responseData = json.decode(response.body);
  return responseData;
}
