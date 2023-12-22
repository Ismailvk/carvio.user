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
  }

  FutureOr<void> fetchUserData(
      FetchUserDataEvent event, Emitter<UserState> emit) async {
    final data = await UserRepo().fetchUserData(event.token);
    data.fold((error) {
      FetchUserDataErrorState(message: error.message);
    }, (response) {
      if (response != null) {
        userModel = UserModel.fromJson(response);
        emit(FetchUserDataSuccessState(userModel: userModel));
      } else {
        emit(FetchUserDataFailedState());
      }
    });
  }
}
