import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/subjects/manager/subjects_state.dart';
import 'package:sen/models/student.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(SubjectsInitial());

  final pageController = PageController();
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  List<String> subjectTitles = [
    "Math",
    "English",
    "Arabic",
  ];
  List<String> subjectAnimations = [
    "assets/animations/math.json",
    "assets/animations/english.json",
    "assets/animations/arabic.json",
    "assets/animations/therapy.json",
  ];
  List<Color> subjectColors = [
    const Color.fromRGBO(210, 223, 255, 1),
    const Color.fromRGBO(255, 228, 187, 1),
    const Color.fromRGBO(225, 255, 187, 1),
    const Color.fromRGBO(228, 187, 255, 1),
  ];
  List<Color> subjectTitleColors = [
    const Color.fromRGBO(78, 103, 168, 1),
    const Color.fromRGBO(170, 137, 87, 1),
    const Color.fromRGBO(104, 137, 63, 1),
    const Color.fromRGBO(130, 63, 137, 1),
  ];

  Future<void> getDifficulties() async {
      String userId = fireAuth.currentUser!.uid;
      await fireStore.collection('users').doc(userId).get().then((value) {
        final student = Student.fromJson(value.data()!);
        if (student.difficulties == "Conduct disorder") {
          subjectTitles.add('Therapy');
        } else {
          subjectTitles.remove('Therapy');
        }
      });
      emit(GetDifficultiesSuccess());
  }
}
