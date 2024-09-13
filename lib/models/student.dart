class Student {
  String userId;
  String age;
  String avatar;
  String grade;
  String name;
  String email;
  String difficulties;

  Student({
    required this.userId,
    required this.age,
    required this.avatar,
    required this.grade,
    required this.name,
    required this.email,
    required this.difficulties,
  });

  Student.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        age = map['childAge'],
        avatar = map['childAvatar'],
        grade = map['childGrade'],
        name = map['childName'],
        email = map['email'],
        difficulties = map['difficulties'];
}
