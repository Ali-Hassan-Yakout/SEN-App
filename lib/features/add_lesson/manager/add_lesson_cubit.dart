import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sen/features/add_lesson/manager/add_lesson_state.dart';
import 'package:sen/generated/l10n.dart';
import 'package:sen/models/teacher.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit() : super(AddLessonInitial());
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final fireAuth = FirebaseAuth.instance;
  final picker = ImagePicker();
  File? videoFile;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Set<String> level = {};
  Teacher teacher = Teacher(
    email: '',
    name: '',
    subject: '',
    userId: '',
    userType: '',
  );
  String downloadUrl = '';
  bool loading = false;

  Future<void> pickVideo() async {
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      emit(PickVideoSuccess());
    }
  }

  Future<void> uploadVideo(String id) async {
    String userId = fireAuth.currentUser!.uid;
    try {
      await storage
          .ref("lessons/$userId/$id")
          .putFile(videoFile!)
          .then((value) async {
        await storage.ref("lessons/$userId/$id").getDownloadURL().then((value) {
          downloadUrl = value;
        });
      });
      emit(UploadVideoSuccess());
    } catch (e) {
      emit(UploadVideoFailure(S().videoUploadFailed));
    }
  }

  Future<void> uploadLesson() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        level.first.isEmpty ||
        videoFile == null) {
      emit(UploadLessonFailure(S().detailsCantBeBlank));
      return;
    }
    loading = true;
    onLoadingChange();
    try {
      String userId = fireAuth.currentUser!.uid;
      String lessonId = DateTime.now().millisecondsSinceEpoch.toString();
      await fireStore.collection('users').doc(userId).get().then((value) {
        teacher = Teacher.fromJson(value.data()!);
      });
      await uploadVideo(lessonId);
      await fireStore.collection('lessons').doc(lessonId).set({
        'lessonId': lessonId,
        'teacherId': teacher.userId,
        'teacherName': teacher.name,
        'subject': teacher.subject ?? "Therapy",
        'level': level.first,
        'title': titleController.text,
        'description': descriptionController.text,
        'url': downloadUrl,
      });
      loading = false;
      onLoadingChange();
      emit(UploadLessonSuccess());
    } catch (e) {
      loading = false;
      onLoadingChange();
      emit(UploadLessonFailure(S().lessonUploadFailed));
    }
  }

  void onLoadingChange() => emit(LoadingChange());
}
