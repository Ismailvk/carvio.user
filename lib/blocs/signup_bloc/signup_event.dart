part of 'signup_bloc.dart';

sealed class SignupEvent {}

class SignupButtonClickEvent extends SignupEvent {
  final Map<String, dynamic> userData;

  SignupButtonClickEvent({required this.userData});
}

class OtpButtonClickedEvent extends SignupEvent {
  final String pin1;
  final String pin2;
  final String pin3;
  final String pin4;

  OtpButtonClickedEvent(
      {required this.pin1,
      required this.pin2,
      required this.pin3,
      required this.pin4});
}
