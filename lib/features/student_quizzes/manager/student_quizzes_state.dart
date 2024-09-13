class StudentQuizzesState {}

final class StudentQuizzesInitial extends StudentQuizzesState {}

final class GetQuizzesSuccess extends StudentQuizzesState {}

final class GetQuizzesFailure extends StudentQuizzesState {
  final String errorMessage;

  GetQuizzesFailure(this.errorMessage);
}
