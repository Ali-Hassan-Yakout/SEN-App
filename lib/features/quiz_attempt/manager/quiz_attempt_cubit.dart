import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/quiz_attempt/manager/quiz_attempt_state.dart';
import 'package:sen/models/quiz.dart';
import 'package:sen/models/student.dart';

class QuizAttemptCubit extends Cubit<QuizAttemptState> {
  QuizAttemptCubit() : super(QuizAttemptInitial());

  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  Student student = Student(
    userId: '',
    age: '',
    avatar: '',
    grade: '',
    name: '',
    email: '',
    difficulties: '',
  );
  List<int> answers = [];

  Future<void> submit(Quiz quiz) async {
    for (var element in answers) {
      if (element == -1) {
        emit(SubmitQuizFailure('Make sure you answered all questions'));
        return;
      }
    }
    try {
      int score = 0;
      String userId = fireAuth.currentUser!.uid;
      await fireStore.collection('users').doc(userId).get().then((value) {
        student = Student.fromJson(value.data()!);
      });
      for (int i = 0; i < quiz.questions.length; i++) {
        if (answers[i] == quiz.questions[i].correctAnswer) {
          score++;
        }
      }
      String attemptId = DateTime.now().microsecondsSinceEpoch.toString();
      await fireStore.collection('attempts').doc(attemptId).set({
        'attemptId': attemptId,
        'studentId': student.userId,
        'teacherId': quiz.teacherId,
        'quizId': quiz.quizId,
        'studentName': student.name,
        'teacherName': quiz.teacherName,
        'quizTitle': quiz.title,
        'description': quiz.description,
        'level': quiz.level,
        'subject': quiz.subject,
        'score': score,
        'answers': answers,
      });
      emit(SubmitQuizSuccess());
    } catch (e) {
      emit(SubmitQuizFailure(e.toString()));
    }
  }
}
