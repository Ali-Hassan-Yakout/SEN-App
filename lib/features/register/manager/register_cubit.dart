import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/database/shared_preferences.dart';
import 'package:sen/features/register/manager/register_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_connectivity.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final parentEmailController = TextEditingController();
  final parentPasswordController = TextEditingController();
  final parentAgeController = TextEditingController();
  final childAgeController = TextEditingController();
  final childNameController = TextEditingController();
  final childGradeController = TextEditingController();
  final teacherEmailController = TextEditingController();
  final teacherPasswordController = TextEditingController();
  final teacherNameController = TextEditingController();
  final therapistEmailController = TextEditingController();
  final therapistPasswordController = TextEditingController();
  final therapistNameController = TextEditingController();
  String childAvatar = "";
  Set<String> teacherSubject = {};
  double progress = 1;
  int mediaIndex = 0;
  String media = "";
  int difficultiesIndex = 0;
  String difficulties = "";
  String userType = "";
  bool validEmail = false;
  bool parentObscure = true;
  bool teacherObscure = true;
  bool therapistObscure = true;
  int numberOfPages = 2;

  Future<void> parentRegister() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: parentEmailController.text,
        password: parentPasswordController.text,
      );
      saveParentData();
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(S().thePasswordProvided));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(S().theAccountAlready));
      }
    } catch (e) {
      if (await AppConnectivity.checkConnection()) {
        emit(RegisterFailure(e.toString()));
      } else {
        emit(RegisterFailure(S().checkYourInternet));
      }
    }
  }

  Future<void> saveParentData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'userId': userId,
        'userType': userType,
        'email': parentEmailController.text,
        'parentAge': parentAgeController.text,
        'childAge': childAgeController.text,
        'childName': childNameController.text,
        'childGrade': childGradeController.text,
        'childAvatar': childAvatar,
        'media': media,
        'difficulties': difficulties,
      },
    );
    PreferenceUtils.setString(PrefKeys.userType, userType);
  }

  Future<void> teacherRegister() async {
    if (teacherEmailController.text.isEmpty ||
        teacherPasswordController.text.isEmpty ||
        teacherNameController.text.isEmpty ||
        teacherSubject.first.isEmpty) {
      emit(RegisterFailure(S().detailsCantBeBlank));
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: teacherEmailController.text,
        password: teacherPasswordController.text,
      );
      saveTeacherData();
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(S().thePasswordProvided));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(S().theAccountAlready));
      }
    } catch (e) {
      if (await AppConnectivity.checkConnection()) {
        emit(RegisterFailure(e.toString()));
      } else {
        emit(RegisterFailure(S().checkYourInternet));
      }
    }
  }

  Future<void> saveTeacherData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'userId': userId,
        'userType': userType,
        'email': teacherEmailController.text,
        'name': teacherNameController.text,
        'subject': teacherSubject.first,
      },
    );
    PreferenceUtils.setString(PrefKeys.userType, userType);
  }

  Future<void> therapistRegister() async {
    if (therapistEmailController.text.isEmpty ||
        therapistPasswordController.text.isEmpty ||
        therapistNameController.text.isEmpty) {
      emit(RegisterFailure(S().detailsCantBeBlank));
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: therapistEmailController.text,
        password: therapistPasswordController.text,
      );
      saveTherapistData();
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(S().thePasswordProvided));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(S().theAccountAlready));
      }
    } catch (e) {
      if (await AppConnectivity.checkConnection()) {
        emit(RegisterFailure(e.toString()));
      } else {
        emit(RegisterFailure(S().checkYourInternet));
      }
    }
  }

  Future<void> saveTherapistData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {
        'userId': userId,
        'userType': userType,
        'email': therapistEmailController.text,
        'name': therapistNameController.text,
      },
    );
    PreferenceUtils.setString(PrefKeys.userType, userType);
  }
}
