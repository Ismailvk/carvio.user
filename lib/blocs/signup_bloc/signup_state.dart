part of 'signup_bloc.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailedState extends SignupState {}

final class SignupErrorState extends SignupState {
  final String message;

  SignupErrorState({required this.message});
}

final class OtpSuccessState extends SignupState {}

final class OtpFailedState extends SignupState {}

final class OtpErrorState extends SignupState {
  final String message;

  OtpErrorState({required this.message});
}
