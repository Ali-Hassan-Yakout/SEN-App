import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/lesson_control/manager/lesson_control_state.dart';
import 'package:sen/models/lesson.dart';

class LessonControlCubit extends Cubit<LessonControlState> {
  LessonControlCubit() : super(LessonControlInitial());
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  List<Lesson> lessons = [];

  Future<void> getLessons() async {
    String userId = fireAuth.currentUser!.uid;
    try {
      await fireStore
          .collection('lessons')
          .where('teacherId', isEqualTo: userId)
          .get()
          .then((value) {
        lessons.clear();
        for (var element in value.docs) {
          lessons.add(Lesson.fromJson(element.data()));
        }
      });
      emit(GetLessonsSuccess());
    } catch (e) {
      emit(GetLessonsFailure(e.toString()));
    }
  }

  Future<void> searchLessons(String searchValue) async {
    String userId = fireAuth.currentUser!.uid;
    try {
      await fireStore
          .collection('lessons')
          .where('teacherId', isEqualTo: userId)
          .get()
          .then(
        (value) {
          lessons.clear();
          for (var element in value.docs) {
            final lesson = Lesson.fromJson(element.data());
            if (lesson.title.startsWith(searchValue)) {
              lessons.add(
                Lesson.fromJson(
                  element.data(),
                ),
              );
            }
          }
        },
      );
      emit(GetLessonsSuccess());
    } catch (e) {
      emit(GetLessonsFailure(e.toString()));
    }
  }

  Future<void> deleteLesson(int index) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await storage.ref('lessons/$userId/${lessons[index].lessonId}').delete();
      await fireStore
          .collection('lessons')
          .doc(lessons[index].lessonId)
          .delete();
      lessons.removeAt(index);
      emit(DeleteLessonsSuccess());
    } catch (e) {
      emit(DeleteLessonsFailure(e.toString()));
    }
  }
}
