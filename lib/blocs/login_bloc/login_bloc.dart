import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;
  LoginBloc(this.userBloc) : super(LoginInitial()) {
    on<LoginButtonEvent>(loginButtonEvent);
  }

  FutureOr<void> loginButtonEvent(
      LoginButtonEvent event, Emitter<LoginState> emit) async {
    final data = await UserRepo().loginUser(event.loginData);
    data.fold((error) {
      emit(LoginErrorState(message: error.message));
    }, (response) {
      final token = response['token'];
      if (token != null) {
        SharedPref.instance.storeToken(token);
        userBloc.add(FetchUserDataEvent(token: token));
        emit(LoginSuccessState());
      } else {
        emit(LoginFailedState());
      }
    });
  }
}
