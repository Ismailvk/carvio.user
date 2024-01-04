part of 'user_data_bloc.dart';

abstract class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class GetUserDataLoadingState extends UserDataState {}

final class GetUserDataSuccessState extends UserDataState {
  final UserModel userModel;

  GetUserDataSuccessState({required this.userModel});
}

final class FetchUserDataErrorState extends UserDataState {}
