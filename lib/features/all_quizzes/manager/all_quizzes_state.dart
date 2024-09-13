class AllQuizzesState {}

final class AllQuizzesInitial extends AllQuizzesState {}

final class GetQuizzesSuccess extends AllQuizzesState {}

final class GetQuizzesFailure extends AllQuizzesState {
  final String errorMessage;

  GetQuizzesFailure(this.errorMessage);
}
