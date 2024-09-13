import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/grades_control/view/grade_control_screen.dart';
import 'package:sen/features/lesson_control/view/lesson_control_screen.dart';
import 'package:sen/features/quiz_control/view/quiz_control_screen.dart';
import 'package:sen/features/report_control/view/report_control_screen.dart';
import 'package:sen/features/teacher_home/manager/teacher_home_state.dart';

class TeacherHomeCubit extends Cubit<TeacherHomeState> {
  TeacherHomeCubit() : super(TeacherHomeInitial());

  int pageIndex = 0;
  List<String> appBarTitles = [
    "Lessons",
    "Quizzes",
    "Grades",
    "Reports",
  ];
  List<Widget> pages = [
    const LessonControlScreen(),
    const QuizControlScreen(),
    const GradeControlScreen(),
    const ReportControlScreen(),
  ];
}
