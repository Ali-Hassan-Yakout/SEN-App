class Report {
  String name;
  String image;
  String lastReportDate;
  String lastReportSubject;
  List<ReportData> reports = [];

  Report({
    required this.name,
    required this.image,
    required this.reports,
    required this.lastReportDate,
    required this.lastReportSubject,
  });

  Report.formJsonTeacher(Map<String, dynamic> map)
      : name = map['childName'],
        image = map['childAvatar'],
        lastReportDate = map['lastReportDate'],
        lastReportSubject = map['lastReportSubject'] {
    map['reportData'].forEach((element) {
      reports.add(ReportData.fromJson(element));
    });
  }

  Report.formJsonChild(Map<String, dynamic> map)
      : name = map['teacherName'],
        image = '',
        lastReportDate = map['lastReportDate'],
        lastReportSubject = map['lastReportSubject'] {
    map['reportData'].forEach((element) {
      reports.add(ReportData.fromJson(element));
    });
  }
}

class ReportData {
  String date;
  String subject;
  String content;

  ReportData({
    required this.date,
    required this.subject,
    required this.content,
  });

  ReportData.fromJson(Map<String, dynamic> map)
      : date = map['date'],
        subject = map['subject'],
        content = map['content'];
}
