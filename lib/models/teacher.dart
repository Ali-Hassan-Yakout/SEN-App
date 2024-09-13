class Teacher {
  String email;
  String name;
  String? subject;
  String userId;
  String userType;

  Teacher({
    required this.email,
    required this.name,
    required this.subject,
    required this.userId,
    required this.userType,
  });

  Teacher.fromJson(Map<String, dynamic> map)
      : email = map['email'],
        name = map['name'],
        subject = map['subject'],
        userId = map['userId'],
        userType = map['userType'];
}
