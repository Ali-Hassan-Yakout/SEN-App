class SendReportState {}

final class SendReportInitial extends SendReportState {}

final class SendReportSuccess extends SendReportState {}

final class SendReportFailure extends SendReportState {
  final String errorMessage;

  SendReportFailure(this.errorMessage);
}
