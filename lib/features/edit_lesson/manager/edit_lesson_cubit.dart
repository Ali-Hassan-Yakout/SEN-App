import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/edit_lesson/manager/edit_lesson_state.dart';

class EditLessonCubit extends Cubit<EditLessonState> {
  EditLessonCubit() : super(EditLessonInitial());
  final fireStore = FirebaseFirestore.instance;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Set<String> level = {};

  Future<void> editLesson(String id) async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        level.first.isEmpty) {
      emit(EditLessonFailure("Details can't be blank"));
      return;
    }
    try {
      await fireStore.collection('lessons').doc(id).update({
        'title': titleController.text,
        'description': descriptionController.text,
        'level': level.first,
      });
      emit(EditLessonSuccess());
    } catch (e) {
      emit(EditLessonFailure('Edit lesson failed'));
    }
  }
}
