abstract class HomeState {}

class HomeInitialState extends HomeState {}

class PhoneSubmittedLoading extends HomeState {}

class PhoneSubmittedSucsses extends HomeState {}

class PhoneSubmittedError extends HomeState {}

class LoginSucsses extends HomeState {}

class LogoutSucsses extends HomeState {}

class LoginWithEmailLoading extends HomeState {}

class LoginWithEmailSucsses extends HomeState {
  String? id;
  LoginWithEmailSucsses(this.id);
}

class LoginWithEmailError extends HomeState {}

class CreateWithEmailLoading extends HomeState {}

class CreateWithEmailSucsses extends HomeState {
  String? id;
  CreateWithEmailSucsses(this.id);
}

class CreateWithEmailError extends HomeState {}

class SaveUserDataLoading extends HomeState {}

class SaveUserDataSucsses extends HomeState {}

class SaveUserDataError extends HomeState {}

class CreateCodeSucsses extends HomeState {}

class CheckVideoSucsses extends HomeState {}

class CheckMutedSucsses extends HomeState {}

class GetUserDataLoading extends HomeState {}

class GetUserDataSucsses extends HomeState {}

class GetUserDataError extends HomeState {}
