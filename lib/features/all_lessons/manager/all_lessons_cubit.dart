import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_lessons/manager/all_lessons_state.dart';
import 'package:sen/models/lesson.dart';

class AllLessonsCubit extends Cubit<AllLessonsState> {
  AllLessonsCubit() : super(AllLessonsInitial());

  final fireStore = FirebaseFirestore.instance;
  List<Lesson> lessons = [];

  Future<void> getLessons(String level, String subject) async {
    try {
      await fireStore
          .collection('lessons')
          .where('level', isEqualTo: level)
          .where('subject', isEqualTo: subject)
          .get()
          .then((value) {
        for (var element in value.docs) {
          lessons.add(Lesson.fromJson(element.data()));
        }
      });
      emit(GetLessonsSuccess());
    } catch (e) {
      emit(GetLessonsFailure(e.toString()));
    }
  }
}
