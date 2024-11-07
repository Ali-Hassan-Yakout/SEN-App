import 'dart:io';

class Lesson {
  String lessonId;
  String teacherId;
  String subject;
  String level;
  String title;
  String teacherName;
  String description;
  String url;
  List<Cards> cards = [];

  Lesson({
    required this.lessonId,
    required this.teacherId,
    required this.subject,
    required this.level,
    required this.title,
    required this.teacherName,
    required this.description,
    required this.url,
  });

  Lesson.fromJson(Map<String, dynamic> map)
      : lessonId = map['lessonId'],
        teacherId = map['teacherId'],
        subject = map['subject'],
        level = map['level'],
        title = map['title'],
        teacherName = map['teacherName'],
        description = map['description'],
        url = map['url'] {
    map['cards'].forEach((element) {
      cards.add(Cards.fromJson(element));
    });
  }
}

class Cards {
  String url;
  File? image;
  String content;

  Cards({
    required this.url,
    required this.content,
  });

  Cards.fromJson(Map<String, dynamic> map)
      : url = map['url'],
        content = map['content'];
}
