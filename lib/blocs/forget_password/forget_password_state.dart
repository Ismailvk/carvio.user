part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordCheckingLoadingState extends ForgetPasswordState {}

final class ForgetPasswordCheckingSuccessState extends ForgetPasswordState {
  final String userId;

  ForgetPasswordCheckingSuccessState({required this.userId});
}

final class ForgetPasswordCheckingErrorState extends ForgetPasswordState {
  final String message;

  ForgetPasswordCheckingErrorState({required this.message});
}

final class ForgetPasswordCheckingFailedState extends ForgetPasswordState {}

// reset password

final class ResetPasswordLoadingState extends ForgetPasswordState {}

final class ResetPasswordSuccessState extends ForgetPasswordState {}

final class ResetPasswordErrorState extends ForgetPasswordState {
  final String message;

  ResetPasswordErrorState({required this.message});
}
