import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> signupUser(
    {required String apiUrl,
    required String fullName,
    required String email,
    required String password,
    required String phoneNo}) async {
  final data = {
    "fullName": fullName,
    "email": email,
    "password": password,
    "phoneNo": phoneNo,
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json', // Set the content type to JSON
    },
    body: json.encode(data), // Encode the data as JSON
  );

  final responseData = json.decode(response.body);
  final message = responseData["message"];
  return message;
}
