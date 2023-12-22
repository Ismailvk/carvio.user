part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent {}

final class ForgetPasswordCheckingEvent extends ForgetPasswordEvent {
  final String email;
  ForgetPasswordCheckingEvent({required this.email});
}

final class ResetPasswordEvent extends ForgetPasswordEvent {
  final Map<String, String> newPasswordData;
  final String userId;

  ResetPasswordEvent({required this.newPasswordData, required this.userId});
}
