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
