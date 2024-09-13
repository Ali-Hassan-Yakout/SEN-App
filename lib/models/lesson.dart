class Lesson {
  String lessonId;
  String teacherId;
  String subject;
  String level;
  String title;
  String teacherName;
  String description;
  String url;

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
        url = map['url'];
}
