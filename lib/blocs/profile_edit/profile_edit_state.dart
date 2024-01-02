import 'dart:io';

abstract class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}

class ProfileUpdateLoadingState extends ProfileEditState {}

class ProfileUpdateSuccsessState extends ProfileEditState {}

class ProfileImageAddedState extends ProfileEditState {
  File imagePath;
  ProfileImageAddedState({required this.imagePath});
}

class ProfileUpdateFailedState extends ProfileEditState {
  String message;
  ProfileUpdateFailedState({required this.message});
}
