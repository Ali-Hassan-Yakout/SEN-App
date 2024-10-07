import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sen/features/add_quiz/Manager/add_quiz_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/models/quiz.dart';
import 'package:sen/models/teacher.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitial());
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final fireAuth = FirebaseAuth.instance;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final picker = ImagePicker();
  List<Map<String, dynamic>> questionsMap = [];
  Teacher teacher = Teacher(
    email: '',
    name: '',
    subject: '',
    userId: '',
    userType: '',
  );
  Set<String> level = {};
  bool loading = false;
  List<QuizData> questions = [];

  void onAddQuestion() {
    questions.add(
      QuizData(
        url: '',
        question: '',
        choices: [
          "",
          "",
          "",
          "",
        ],
        correctAnswer: 0,
      ),
    );
    emit(AddQuestionSuccess());
  }

  void deleteQuestion(int index) {
    questions.removeAt(index);
    emit(RemoveQuestionSuccess());
  }

  Future<void> pickImage(int index) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      questions[index].image = File(pickedFile.path);
      emit(PickImageSuccess());
    }
  }

  Future<void> uploadImage(String id, int index) async {
    String userId = fireAuth.currentUser!.uid;
    String questionId = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await storage
          .ref("quizzes/$userId/$id/$questionId")
          .putFile(questions[index].image!)
          .then((value) async {
        await storage
            .ref("quizzes/$userId/$id/$questionId")
            .getDownloadURL()
            .then((value) {
          questions[index].url = value;
        });
      });
      emit(UploadImageSuccess());
    } catch (e) {
      emit(UploadImageFailure(S().imageUploadFailed));
    }
  }

  Future<void> uploadQuiz() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        level.first.isEmpty ||
        questions.isEmpty) {
      emit(UploadQuizFailure(S().detailsCantBeBlank));
      return;
    }
    loading = true;
    onLoadingChange();
    try {
      String userId = fireAuth.currentUser!.uid;
      String quizId = DateTime.now().millisecondsSinceEpoch.toString();
      await fireStore.collection('users').doc(userId).get().then((value) {
        teacher = Teacher.fromJson(value.data()!);
      });
      for (int i = 0; i < questions.length; i++) {
        if (questions[i].image != null) {
          await uploadImage(quizId, i);
        }
        questionsMap.add({
          'url': questions[i].url,
          'question': questions[i].question,
          'choices': questions[i].choices,
          'correctAnswer': questions[i].correctAnswer,
        });
      }

      await fireStore.collection('quizzes').doc(quizId).set({
        'quizId': quizId,
        'teacherId': teacher.userId,
        'teacherName': teacher.name,
        'subject': teacher.subject ?? 'Therapy',
        'title': titleController.text,
        'description': descriptionController.text,
        'level': level.first,
        'questions': questionsMap,
      });
      loading = false;
      onLoadingChange();
      emit(UploadQuizSuccess());
    } catch (e) {
      loading = false;
      onLoadingChange();
      emit(UploadQuizFailure(S().quizUploadFailed));
    }
  }

  void onLoadingChange() => emit(LoadingChange());
}
