import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/report_control/manager/report_control_state.dart';
import 'package:sen/models/report.dart';

class ReportControlCubit extends Cubit<ReportControlState> {
  ReportControlCubit() : super(ReportControlInitial());

  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  List<Report> reports = [];

  Future<void> getReports() async {
    try {
      reports.clear();
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('reports')
          .where('teacherId', isEqualTo: userId)
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            reports.add(
              Report.formJsonTeacher(element.data()),
            );
          }
        },
      );
      emit(GetReportSuccess());
    } catch (e) {
      emit(GetReportFailure(e.toString()));
    }
  }
}
