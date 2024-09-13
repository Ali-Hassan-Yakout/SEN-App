import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_quizzes/manager/all_quizzes_state.dart';
import 'package:sen/models/attempt.dart';
import 'package:sen/models/quiz.dart';

class AllQuizzesCubit extends Cubit<AllQuizzesState> {
  AllQuizzesCubit() : super(AllQuizzesInitial());

  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  List<Quiz> quizzes = [];
  List<Attempt> attempts = [];

  Future<void> getQuizzes(String level, String subject) async {
    attempts.clear();
    quizzes.clear();
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('attempts')
          .where('studentId', isEqualTo: userId)
          .get()
          .then((value) {
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
        for (var element in value.docs) {
          final quiz = Quiz.fromJson(element.data());
          if (attempts.isEmpty) {
            quizzes.add(quiz);
          } else {
            if (!attempts.any((element) => element.quizId == quiz.quizId)) {
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
