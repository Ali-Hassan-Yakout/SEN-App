import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/features/forget_password/manager/forget_password_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/utils/app_connectivity.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final emailController = TextEditingController();

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      emit(ResetPasswordFailure(S().emailCantBeBlank));
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      emit(ResetPasswordSuccess());
    } catch (error) {
      if (await AppConnectivity.checkConnection()) {
        emit(ResetPasswordFailure(S().tryAgainLater));
      } else {
        emit(ResetPasswordFailure(S().checkYourInternet));
      }
    }
  }
}
