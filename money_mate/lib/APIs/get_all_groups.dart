import 'dart:convert';
import 'package:http/http.dart' as http;
import './groupsClass.dart';

Future<ApiResponse> getGroupsApi({
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

  final dynamic responseData = json.decode(response.body);

  if (responseData is Map<String, dynamic>) {
    return ApiResponse.fromJson(responseData);
  } else {
    // Handle the case where responseData is not a Map
    print('Unexpected response format');
    return ApiResponse(message: '', totalExpense: 0, groups: []);
  }
}
