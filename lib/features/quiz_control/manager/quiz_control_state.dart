class QuizControlState {}

final class QuizControlInitial extends QuizControlState {}

final class GetQuizzesSuccess extends QuizControlState {}

final class GetQuizzesFailure extends QuizControlState {
  final String errorMessage;

  GetQuizzesFailure(this.errorMessage);
}

final class DeleteQuizzesSuccess extends QuizControlState {}

final class DeleteQuizzesFailure extends QuizControlState {
  final String errorMessage;

  DeleteQuizzesFailure(this.errorMessage);
}
