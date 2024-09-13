import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_reports/view/all_reports_screen.dart';
import 'package:sen/features/parent_home/manager/parent_home_state.dart';
import 'package:sen/features/subjects/view/subjects_screen.dart';

class ParentHomeCubit extends Cubit<ParentHomeState> {
  ParentHomeCubit() : super(ParentHomeInitial());

  int pageIndex = 0;
  List<String> appBarTitles = [
    "Subjects",
    "Quizzes",
    "Grades",
    "Reports",
  ];
  List<Widget> pages = [
    const SubjectsScreen(screen: 'subjects'),
    const SubjectsScreen(screen: 'quizzes'),
    const SubjectsScreen(screen: 'grades'),
    const AllReportsScreen(),
  ];
}
