import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/all_reports/manager/all_reports_state.dart';
import 'package:sen/models/report.dart';

class AllReportsCubit extends Cubit<AllReportsState> {
  AllReportsCubit() : super(AllReportsInitial());

  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  List<Report> reports = [];

  Future<void> getReports() async {
    try {
      reports.clear();
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('reports')
          .where('childId', isEqualTo: userId)
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            reports.add(
              Report.formJsonChild(element.data()),
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
