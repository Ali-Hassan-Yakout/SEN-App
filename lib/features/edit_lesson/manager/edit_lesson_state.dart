class EditLessonState {}

final class EditLessonInitial extends EditLessonState {}

final class EditLessonSuccess extends EditLessonState {}

final class EditLessonFailure extends EditLessonState {
  final String errorMessage;

  EditLessonFailure(this.errorMessage);
}
