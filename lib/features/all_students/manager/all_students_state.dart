class AllStudentsState {}

final class AllStudentsInitial extends AllStudentsState {}

final class GetStudentsSuccess extends AllStudentsState {}

final class GetStudentsFailure extends AllStudentsState {
  final String errorMessage;

  GetStudentsFailure(this.errorMessage);
}
