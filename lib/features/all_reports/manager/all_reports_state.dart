class AllReportsState {}

final class AllReportsInitial extends AllReportsState {}

final class GetReportSuccess extends AllReportsState {}

final class GetReportFailure extends AllReportsState {
  final String errorMessage;

  GetReportFailure(this.errorMessage);
}
