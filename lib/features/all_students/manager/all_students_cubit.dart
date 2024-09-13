import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_students/manager/all_students_state.dart';
import 'package:sen/models/student.dart';

class AllStudentsCubit extends Cubit<AllStudentsState> {
  AllStudentsCubit() : super(AllStudentsInitial());
  final fireStore = FirebaseFirestore.instance;
  List<Student> students = [];

  Future<void> getStudents() async {
    students.clear();
    try {
      await fireStore
          .collection('users')
          .where('userType', isEqualTo: "parent")
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            students.add(
              Student.fromJson(
                element.data(),
              ),
            );
          }
        },
      );
      emit(GetStudentsSuccess());
    } catch (e) {
      emit(GetStudentsFailure(e.toString()));
    }
  }

  Future<void> searchStudents(String searchValue) async {
    try {
      await fireStore
          .collection('users')
          .where('userType', isEqualTo: "parent")
          .get()
          .then(
        (value) {
          students.clear();
          for (var element in value.docs) {
            final student = Student.fromJson(element.data());
            if (student.name.startsWith(searchValue)) {
              students.add(
                Student.fromJson(
                  element.data(),
                ),
              );
            }
          }
        },
      );
      emit(GetStudentsSuccess());
    } catch (e) {
      emit(GetStudentsFailure(e.toString()));
    }
  }
}
