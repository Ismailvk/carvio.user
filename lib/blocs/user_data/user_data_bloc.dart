import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:user_side/data/netword/api_service.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/models/user_model.dart';

import '../../repositories/user_repo.dart';
part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<FetchUserData>(fetchUserData);
    on<FetchUserDataFailedEvent>(fetchUserDataFailedEvent);
    on<UpdateUserEvent>(updateUserEvent);
  }
  late UserModel user;

  FutureOr<void> fetchUserData(
      FetchUserData event, Emitter<UserDataState> emit) {
    user = event.userModel;
    emit(GetUserDataSuccessState(userModel: event.userModel));
  }

  FutureOr<void> fetchUserDataFailedEvent(
      FetchUserDataFailedEvent event, Emitter<UserDataState> emit) {
    emit(FetchUserDataErrorState());
  }

  Future<FutureOr<void>> updateUserEvent(
      UpdateUserEvent event, Emitter<UserDataState> emit) async {
    emit(GetUserDataLoadingState());
    if (event.imagePath != null) {
      final response1 = await ApiService().profileUpdate(event.imagePath!);
      final responsBody = await response1.stream.bytesToString();
      print(responsBody);
    }
    await ApiService().dataUpdate(event.data);

    final token = SharedPref.instance.getToke();

    final data = await UserRepo().fetchUserData(token!);
    data.fold(
      (left) => emit(FetchUserDataErrorState()),
      (right) {
        if (right != null) {
          var userModel = UserModel.fromJson(right);
          user = userModel;
          emit(GetUserDataSuccessState(userModel: userModel));
        } else {
          emit(FetchUserDataErrorState());
        }
      },
    );
  }

  // FutureOr<void> submitClicked(
  //     SubmitClicked event, Emitter<ProfileEditState> emit) async {
  //   emit(ProfileUpdateLoadingState());
  //   final response = await ApiService().dataUpdate(event.data);
  //   print(response.statusCode);
  //   final response1 = await ApiService().profileUpdate(event.imagepath);
  //   print(response1.statusCode);
  //   if (response1.statusCode == 200) {
  //     emit(ProfileUpdateSuccsessState());
  //   } else {
  //     emit(ProfileUpdateFailedState(message: "Somthing Went Wrong"));
  //   }
  //   final responsBody = await response1.stream.bytesToString();
  //   print(responsBody);
  // }
}
