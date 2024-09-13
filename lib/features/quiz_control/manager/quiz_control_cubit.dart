import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/quiz_control/manager/quiz_control_state.dart';
import 'package:sen/models/quiz.dart';

class QuizControlCubit extends Cubit<QuizControlState> {
  QuizControlCubit() : super(QuizControlInitial());
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  List<Quiz> quizzes = [];

  Future<void> getQuizzes() async {
    String userId = fireAuth.currentUser!.uid;
    try {
      await fireStore
          .collection('quizzes')
          .where('teacherId', isEqualTo: userId)
          .get()
          .then((value) {
        quizzes.clear();
        for (var element in value.docs) {
          quizzes.add(Quiz.fromJson(element.data()));
        }
      });
      emit(GetQuizzesSuccess());
    } catch (e) {
      emit(GetQuizzesFailure(e.toString()));
    }
  }

  Future<void> searchQuizzes(String searchValue) async {
    String userId = fireAuth.currentUser!.uid;
    try {
      await fireStore
          .collection('quizzes')
          .where('teacherId', isEqualTo: userId)
          .get()
          .then(
        (value) {
          quizzes.clear();
          for (var element in value.docs) {
            final quiz = Quiz.fromJson(element.data());
            if (quiz.title.startsWith(searchValue)) {
              quizzes.add(
                Quiz.fromJson(
                  element.data(),
                ),
              );
            }
          }
        },
      );
      emit(GetQuizzesSuccess());
    } catch (e) {
      emit(GetQuizzesFailure(e.toString()));
    }
  }

  Future<void> deleteQuiz(int index) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      final list = await storage
          .ref('quizzes/$userId/${quizzes[index].quizId}')
          .listAll();
      for (var item in list.items) {
        await item.delete();
      }
      await fireStore.collection('quizzes').doc(quizzes[index].quizId).delete();
      await fireStore
          .collection('attempts')
          .where('quizId', isEqualTo: quizzes[index].quizId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
      });
      quizzes.removeAt(index);
      emit(DeleteQuizzesSuccess());
    } catch (e) {
      emit(DeleteQuizzesFailure(e.toString()));
    }
  }
}
