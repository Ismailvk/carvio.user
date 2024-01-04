part of 'user_data_bloc.dart';

sealed class UserDataEvent {}

final class FetchUserData extends UserDataEvent {
  final UserModel userModel;

  FetchUserData({required this.userModel});
}

final class FetchUserDataFailedEvent extends UserDataEvent {}

final class UpdateUserEvent extends UserDataEvent {
  final Map<String, dynamic> data;
  final File? imagePath;

  UpdateUserEvent({required this.data, this.imagePath});
}
