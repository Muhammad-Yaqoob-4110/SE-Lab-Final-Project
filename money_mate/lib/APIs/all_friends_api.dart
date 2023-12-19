import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResponse {
  final List<Friend> friends;

  ApiResponse({
    required this.friends,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      friends: (json['friends'] as List<dynamic>?)
              ?.map((friend) => Friend.fromJson(friend))
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'ApiResponse{friends: $friends}';
  }
}

class Friend {
  final String id;
  final String email;
  final String name;

  Friend({
    required this.id,
    required this.email,
    required this.name,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
    };
  }
}

Future<ApiResponse> allFriendsApi({
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
    return ApiResponse(friends: []);
  }
}
