class LessonControlState {}

final class LessonControlInitial extends LessonControlState {}

final class GetLessonsSuccess extends LessonControlState {}

final class GetLessonsFailure extends LessonControlState {
  final String errorMessage;

  GetLessonsFailure(this.errorMessage);
}

final class DeleteLessonsSuccess extends LessonControlState {}

final class DeleteLessonsFailure extends LessonControlState {
  final String errorMessage;

  DeleteLessonsFailure(this.errorMessage);
}
