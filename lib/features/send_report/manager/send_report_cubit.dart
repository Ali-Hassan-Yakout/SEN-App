import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/send_report/manager/send_report_state.dart';
import 'package:sen/models/student.dart';
import 'package:sen/models/teacher.dart';

class SendReportCubit extends Cubit<SendReportState> {
  SendReportCubit() : super(SendReportInitial());

  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final subjectController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late Teacher teacher;

  Future<void> sentReport(Student student) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore.collection('users').doc(userId).get().then((value) {
        teacher = Teacher.fromJson(value.data()!);
      });
      await fireStore.collection('reports').doc(userId).set(
        {
          'teacherId': userId,
          'childId': student.userId,
          'teacherName': teacher.name,
          'childName': student.name,
          'childAvatar': student.avatar,
          'lastReportDate': DateTime.now().toString(),
          'lastReportSubject': subjectController.text,
          'reportData': FieldValue.arrayUnion(
            [
              {
                'subject': subjectController.text,
                'content': contentController.text,
                'date': DateTime.now().toString(),
              }
            ],
          )
        },
        SetOptions(merge: true),
      );
      emit(SendReportSuccess());
    } catch (e) {
      emit(SendReportFailure(e.toString()));
    }
  }
}
