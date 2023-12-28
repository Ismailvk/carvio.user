import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/models/user_model.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserModel userModel;
  UserBloc() : super(UserInitial()) {
    on<FetchUserDataEvent>(fetchUserData);
    on<ResetPasswordEvent>(resetPassword);
  }

  FutureOr<void> fetchUserData(
      FetchUserDataEvent event, Emitter<UserState> emit) async {
    final data = await UserRepo().fetchUserData(event.token);
    data.fold((error) {
      emit(FetchUserDataErrorState(message: error.message));
    }, (response) {
      if (response != null) {
        userModel = UserModel.fromJson(response);

        emit(FetchUserDataSuccessState(userModel: userModel));
      } else {
        emit(FetchUserDataFailedState());
      }
    });
  }

  FutureOr<void> resetPassword(
      ResetPasswordEvent event, Emitter<UserState> emit) async {
    final data = {
      "oldpass": event.oldPassword,
      "newpass": event.newPassword,
      "confirmpass": event.confirmPassword,
    };

    final responseData = await UserRepo().changePassword(data);
    responseData.fold((error) {
      emit(ResetPasswordErrorState(message: error.message));
    }, (response) {
      if (response['message'] == "Success") {
        emit(ResetPasswordSuccessState());
      } else {
        emit(ResetPasswordFailedState(message: response['message']));
      }
    });
  }
}
