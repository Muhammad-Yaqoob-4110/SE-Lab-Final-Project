import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginUserApiCall({
  required String apiUrl,
  required String email,
  required String password,
}) async {
  final data = {
    "email": email,
    "password": password,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json', // Set the content type to JSON
    },
    body: json.encode(data), // Encode the data as JSON
  );

  final responseData = json.decode(response.body);
  return responseData;
}
