import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sen/database/shared_preferences.dart';
import 'package:sen/features/settings/manager/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  Future<void> signOut() async {
    try {
      fireAuth.signOut();
      await PreferenceUtils.setString(PrefKeys.userType, "");
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }

  Future<void> deleteProfile() async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore.collection('users').doc(userId).delete();
      await fireAuth.currentUser!.delete();
      await PreferenceUtils.setString(PrefKeys.userType, "");
      emit(DeleteProfileSuccess());
    } catch (e) {
      emit(DeleteProfileFailure(e.toString()));
    }
  }
}
