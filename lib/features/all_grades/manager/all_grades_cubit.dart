import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_grades/manager/all_grades_state.dart';
import 'package:sen/models/attempt.dart';
import 'package:sen/models/quiz.dart';

class AllGradesCubit extends Cubit<AllGradesState> {
  AllGradesCubit() : super(AllGradesInitial());

  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  List<Quiz> quizzes = [];
  List<Attempt> attempts = [];

  Future<void> getQuizzes(String level, String subject) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('attempts')
          .where('studentId', isEqualTo: userId)
          .where('level', isEqualTo: level)
          .where('subject', isEqualTo: subject)
          .get()
          .then((value) {
        attempts.clear();
        for (var element in value.docs) {
          attempts.add(Attempt.fromJson(element.data()));
        }
      });
      await fireStore
          .collection('quizzes')
          .where('level', isEqualTo: level)
          .where('subject', isEqualTo: subject)
          .get()
          .then((value) {
        quizzes.clear();
        for (var element in value.docs) {
          Quiz quiz = Quiz.fromJson(element.data());
          for (var attempt in attempts) {
            if (quiz.quizId == attempt.quizId) {
              quizzes.add(Quiz.fromJson(element.data()));
            }
          }
        }
      });
      emit(GetQuizzesSuccess());
    } catch (e) {
      emit(GetQuizzesFailure(e.toString()));
    }
  }
}
