import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getAllGroups(
    {required String apiUrl, required String userEmail}) async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/$userEmail'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {'groups': List<Map<String, dynamic>>.from(data['groups'])};
    } else {
      print('Error: ${response.statusCode}');
      return {'error': 'Error fetching groups'};
    }
  } catch (error) {
    print('Error: $error');
    return {'error': 'An unexpected error occurred'};
  }
}
