import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> updateUserInformation({
  required String apiUrl,
  required String fullName,
  required String password,
  required String phoneNo,
}) async {
  final data = {
    "fullName": fullName,
    "password": password,
    "phoneNo": phoneNo,
  };

  final response = await http.put(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json', // Set the content type to JSON
    },
    body: json.encode(data), // Encode the data as JSON
  );

  final responseData = json.decode(response.body);
  return responseData;
}
