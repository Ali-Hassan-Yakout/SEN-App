class AddLessonState {}

final class AddLessonInitial extends AddLessonState {}

final class PickVideoSuccess extends AddLessonState {}

final class LoadingChange extends AddLessonState {}

final class UploadLessonSuccess extends AddLessonState {}

final class UploadLessonFailure extends AddLessonState {
  final String errorMessage;

  UploadLessonFailure(this.errorMessage);
}

final class UploadVideoSuccess extends AddLessonState {}

final class UploadVideoFailure extends AddLessonState {
  final String errorMessage;

  UploadVideoFailure(this.errorMessage);
}
