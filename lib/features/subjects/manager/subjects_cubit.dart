import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/subjects/manager/subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());

  final pageController = PageController();
  List<String> subjectTitles = [
    "Math",
    "English",
    "Arabic",
  ];
  List<String> subjectAnimations = [
    "assets/animations/math.json",
    "assets/animations/english.json",
    "assets/animations/arabic.json",
  ];
  List<Color> subjectColors = [
    const Color.fromRGBO(210, 223, 255, 1),
    const Color.fromRGBO(255, 228, 187, 1),
    const Color.fromRGBO(225, 255, 187, 1),
  ];
  List<Color> subjectTitleColors = [
    const Color.fromRGBO(78, 103, 168, 1),
    const Color.fromRGBO(170, 137, 87, 1),
    const Color.fromRGBO(104, 137, 63, 1),
  ];
}
