import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> addMemberToGroup({
  required String apiUrl,
  required String groupId,
  required String userEmail,
}) async {
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'groupId': groupId,
        'userEmail': userEmail,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {'message': data['message'], 'group': data['group']};
    } else if (response.statusCode == 400) {
      final data = json.decode(response.body);
      return {'error': data['message']};
    } else {
      print('Error: ${response.statusCode}');
      return {'error': 'Error adding member to the group'};
    }
  } catch (error) {
    print('Error: $error');
    return {'error': 'An unexpected error occurred'};
  }
}
