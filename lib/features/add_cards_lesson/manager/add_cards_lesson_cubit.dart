import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sen/features/add_cards_lesson/manager/add_cards_lesson_state.dart';

import 'package:sen/generated/l10n.dart';
import 'package:sen/models/lesson.dart';
import 'package:sen/models/teacher.dart';

class AddCardsLessonCubit extends Cubit<AddCardsLessonState> {
  AddCardsLessonCubit() : super(AddLessonInitial());
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final fireAuth = FirebaseAuth.instance;
  final picker = ImagePicker();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<Cards> cards = [];
  List<Map<String, dynamic>> cardsMap = [];
  Set<String> level = {};
  Teacher teacher = Teacher(
    email: '',
    name: '',
    subject: '',
    userId: '',
    userType: '',
  );
  bool loading = false;

  Future<void> uploadLesson() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        level.first.isEmpty ||
        cards.isEmpty) {
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

      for (int i = 0; i < cards.length; i++) {
        if (cards[i].image != null) {
          await uploadImage(lessonId, i);
        }
        cardsMap.add({
          'url': cards[i].url,
          'content':cards[i].content,
        });
      }
      await fireStore.collection('lessons').doc(lessonId).set({
        'lessonId': lessonId,
        'teacherId': teacher.userId,
        'teacherName': teacher.name,
        'subject': teacher.subject ?? "Therapy",
        'level': level.first,
        'title': titleController.text,
        'description': descriptionController.text,
        'url': "",
        'cards':cardsMap,
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

  void onAddCard() {
    cards.add(
      Cards(
        url: '',
        content: '',
      ),
    );
    emit(AddCardSuccess());
  }

  void deleteCard(int index) {
    cards.removeAt(index);
    emit(RemoveCardSuccess());
  }

  Future<void> pickImage(int index) async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cards[index].image = File(pickedFile.path);
      emit(PickImageSuccess());
    }
  }

  Future<void> uploadImage(String id, int index) async {
    String userId = fireAuth.currentUser!.uid;
    String cardId = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await storage
          .ref("lessons/$userId/$id/$cardId")
          .putFile(cards[index].image!)
          .then((value) async {
        await storage
            .ref("lessons/$userId/$id/$cardId")
            .getDownloadURL()
            .then((value) {
          cards[index].url = value;
        });
      });
      emit(UploadImageSuccess());
    } catch (e) {
      emit(UploadImageFailure(S().imageUploadFailed));
    }
  }

  void onLoadingChange() => emit(LoadingChange());
}
