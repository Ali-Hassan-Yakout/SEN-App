class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ResetPasswordSuccess extends ForgetPasswordState {}

final class ResetPasswordFailure extends ForgetPasswordState {
  final String errorMessage;

  ResetPasswordFailure(this.errorMessage);
}
