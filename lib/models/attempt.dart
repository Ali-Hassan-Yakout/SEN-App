class Attempt {
  String attemptId;
  String studentId;
  String teacherId;
  String quizId;
  String studentName;
  String teacherName;
  String quizTitle;
  String description;
  String level;
  String subject;
  int score;
  List<dynamic> answers = [];

  Attempt({
    required this.attemptId,
    required this.studentId,
    required this.teacherId,
    required this.quizId,
    required this.studentName,
    required this.teacherName,
    required this.quizTitle,
    required this.description,
    required this.level,
    required this.subject,
    required this.score,
    required this.answers,
  });

  Attempt.fromJson(Map<String, dynamic> map)
      : attemptId = map['attemptId'],
        studentId = map['studentId'],
        teacherId = map['teacherId'],
        quizId = map['quizId'],
        studentName = map['studentName'],
        teacherName = map['teacherName'],
        quizTitle = map['quizTitle'],
        description = map['description'],
        level = map['level'],
        subject = map['subject'],
        score = map['score'],
        answers = map['answers'];
}
