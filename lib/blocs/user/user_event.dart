part of 'user_bloc.dart';

abstract class UserEvent {}

final class FetchUserDataEvent extends UserEvent {
  final String token;

  FetchUserDataEvent({required this.token});
}

final class FetchAllVehicle extends UserEvent {}

final class FetchBookingDataEvent extends UserEvent {}

final class ResetPasswordEvent extends UserEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordEvent(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmPassword});
}
