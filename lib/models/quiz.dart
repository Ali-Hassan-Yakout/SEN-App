import 'dart:io';

class Quiz {
  String quizId;
  String teacherId;
  String teacherName;
  String? subject;
  String title;
  String description;
  String level;
  List<QuizData> questions = [];

  Quiz({
    required this.quizId,
    required this.teacherId,
    required this.teacherName,
    required this.subject,
    required this.title,
    required this.description,
    required this.level,
    required this.questions,
  });

  Quiz.fromJson(Map<String, dynamic> map)
      : quizId = map['quizId'],
        teacherId = map['teacherId'],
        teacherName = map['teacherName'],
        subject = map['subject'],
        title = map['title'],
        description = map['description'],
        level = map['level'] {
    map['questions'].forEach((element) {
      questions.add(QuizData.fromJson(element));
    });
  }
}

class QuizData {
  String url;
  File? image;
  String question;
  List<dynamic> choices;
  int correctAnswer;

  QuizData({
    required this.url,
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });

  QuizData.fromJson(Map<String, dynamic> map)
      : url = map['url'],
        question = map['question'],
        choices = map['choices'],
        correctAnswer = map['correctAnswer'];
}
