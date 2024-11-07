class AddVideoLessonState {}

final class AddLessonInitial extends AddVideoLessonState {}

final class PickVideoSuccess extends AddVideoLessonState {}

final class LoadingChange extends AddVideoLessonState {}

final class UploadLessonSuccess extends AddVideoLessonState {}

final class UploadLessonFailure extends AddVideoLessonState {
  final String errorMessage;

  UploadLessonFailure(this.errorMessage);
}

final class UploadVideoSuccess extends AddVideoLessonState {}

final class UploadVideoFailure extends AddVideoLessonState {
  final String errorMessage;

  UploadVideoFailure(this.errorMessage);
}
