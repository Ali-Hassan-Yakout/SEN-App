class GradesControlState {}

final class GradesControlInitial extends GradesControlState {}

final class GetStudentsSuccess extends GradesControlState {}

final class GetStudentsFailure extends GradesControlState {
  final String errorMessage;

  GetStudentsFailure(this.errorMessage);
}
