part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class FetchUserDataLoadingState extends UserState {}

final class FetchUserDataSuccessState extends UserState {
  UserModel userModel;

  FetchUserDataSuccessState({required this.userModel});
}

final class FetchUserDataErrorState extends UserState {
  final String message;

  FetchUserDataErrorState({required this.message});
}

final class FetchUserDataFailedState extends UserState {}

// Reset Password

final class ResetPasswordLoadingState extends UserState {}

final class ResetPasswordSuccessState extends UserState {}

final class ResetPasswordErrorState extends UserState {
  final String message;

  ResetPasswordErrorState({required this.message});
}

final class ResetPasswordFailedState extends UserState {
  final String message;

  ResetPasswordFailedState({required this.message});
}

// Get booking data
final class FetchBookingDataSuccessState extends UserState {
  List<BookingModel> completeList;
  List<BookingModel> upcomingList;
  List<BookingModel> activeList;

  FetchBookingDataSuccessState({
    required this.completeList,
    required this.upcomingList,
    required this.activeList,
  });
}

final class FetchBookingDataErrorState extends UserState {
  final String message;

  FetchBookingDataErrorState({required this.message});
}

final class FetchBookingDataFailedState extends UserState {}

final class FetchGetAllVehicleFailedState extends UserState {
  final String message;

  FetchGetAllVehicleFailedState({required this.message});
}
