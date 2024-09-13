class AllLessonsState {}

final class AllLessonsInitial extends AllLessonsState {}

final class GetLessonsSuccess extends AllLessonsState {}

final class GetLessonsFailure extends AllLessonsState {
  final String errorMessage;

  GetLessonsFailure(this.errorMessage);
}
