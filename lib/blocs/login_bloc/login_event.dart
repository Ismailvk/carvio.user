part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginButtonEvent extends LoginEvent {
  final Map<String, String> loginData;

  LoginButtonEvent({required this.loginData});
}
