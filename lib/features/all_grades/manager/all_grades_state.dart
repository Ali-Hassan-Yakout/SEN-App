class AllGradesState {}

final class AllGradesInitial extends AllGradesState {}

final class GetQuizzesSuccess extends AllGradesState {}

final class GetQuizzesFailure extends AllGradesState {
  final String errorMessage;

  GetQuizzesFailure(this.errorMessage);
}
