class QuizAttemptState {}

final class QuizAttemptInitial extends QuizAttemptState {}

final class SubmitQuizSuccess extends QuizAttemptState {}

final class SubmitQuizFailure extends QuizAttemptState {
  final String errorMessage;

  SubmitQuizFailure(this.errorMessage);
}
