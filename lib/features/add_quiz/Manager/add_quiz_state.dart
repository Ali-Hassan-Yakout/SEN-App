class AddQuizState {}

final class AddQuizInitial extends AddQuizState {}

final class AddQuestionSuccess extends AddQuizState {}

final class RemoveQuestionSuccess extends AddQuizState {}

final class PickImageSuccess extends AddQuizState {}

final class UploadImageSuccess extends AddQuizState {}

final class UploadImageFailure extends AddQuizState {
  final String errorMessage;

  UploadImageFailure(this.errorMessage);
}

final class LoadingChange extends AddQuizState {}

final class UploadQuizSuccess extends AddQuizState {}

final class UploadQuizFailure extends AddQuizState {
  final String errorMessage;

  UploadQuizFailure(this.errorMessage);
}
