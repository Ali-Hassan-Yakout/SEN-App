import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/database/shared_preferences.dart';
import 'package:sen/features/login/manager/login_state.dart';
import 'package:sen/utils/app_connectivity.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  String errorMessage = "";
  double progress = 0.5;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage = "Email or password can't be blank";
      emit(LoginFailure());
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      getUserType();
    } catch (error) {
      if (await AppConnectivity.checkConnection()) {
        errorMessage = "Invalid Credentials!";
        emit(LoginFailure());
      } else {
        errorMessage = "Check Your internet!";
        emit(LoginFailure());
      }
    }
  }

  Future<void> getUserType() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String userType = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      userType = value['userType'];
    });
    await PreferenceUtils.setString(
      PrefKeys.userType,
      userType,
    );
    emit(LoginSuccess());
  }
}
