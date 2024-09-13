class ReportControlState {}

final class ReportControlInitial extends ReportControlState {}

final class GetReportSuccess extends ReportControlState {}

final class GetReportFailure extends ReportControlState {
  final String errorMessage;

  GetReportFailure(this.errorMessage);
}
