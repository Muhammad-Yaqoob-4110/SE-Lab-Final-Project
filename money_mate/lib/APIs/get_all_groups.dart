import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getGroupsApi({
  required String apiUrl,
  required String bearerToken,
}) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
  );

  final responseData = json.decode(response.body);
  // print(responseData);
  return responseData;
}
