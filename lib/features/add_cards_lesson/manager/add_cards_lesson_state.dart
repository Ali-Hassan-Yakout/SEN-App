class AddCardsLessonState {}

final class AddLessonInitial extends AddCardsLessonState {}

final class LoadingChange extends AddCardsLessonState {}

final class AddCardSuccess extends AddCardsLessonState {}

final class RemoveCardSuccess extends AddCardsLessonState {}

final class PickImageSuccess extends AddCardsLessonState {}

final class UploadLessonSuccess extends AddCardsLessonState {}

final class UploadLessonFailure extends AddCardsLessonState {
  final String errorMessage;

  UploadLessonFailure(this.errorMessage);
}

final class UploadImageSuccess extends AddCardsLessonState {}

final class UploadImageFailure extends AddCardsLessonState {
  final String errorMessage;

  UploadImageFailure(this.errorMessage);
}
