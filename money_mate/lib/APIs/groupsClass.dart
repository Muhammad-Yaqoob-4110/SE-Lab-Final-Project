class ApiResponse {
  String message;
  int totalExpense;
  List<Group> groups;

  ApiResponse({
    required this.message,
    required this.totalExpense,
    required this.groups,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      totalExpense: json['totalExpense'],
      groups: List<Group>.from(
          json['groups'].map((group) => Group.fromJson(group))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'totalExpense': totalExpense,
      'groups': groups.map((group) => group.toJson()).toList(),
    };
  }
}

class Group {
  String id;
  String name;
  String createdBy;
  List<Member> members;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Group({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['_id'],
      name: json['name'],
      createdBy: json['createdBy'],
      members: List<Member>.from(
          json['members'].map((member) => Member.fromJson(member))),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'createdBy': createdBy,
      'members': members.map((member) => member.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class Member {
  String email;
  int amount;
  String memberId;

  Member({
    required this.email,
    required this.amount,
    required this.memberId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      email: json['email'],
      amount: json['amount'],
      memberId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'amount': amount,
      '_id': memberId,
    };
  }
}
