import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordCheckingEvent>(forgetPasswordCheckingEvent);
    on<ResetPasswordEvent>(resetPasswordEvent);
  }

  FutureOr<void> forgetPasswordCheckingEvent(ForgetPasswordCheckingEvent event,
      Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordCheckingLoadingState());
    final data = {'email': event.email};
    final response = await UserRepo().forgetPasswordEmailChecking(data);
    response.fold((error) {
      emit(ForgetPasswordCheckingErrorState(message: error.message));
    }, (response) {
      if (response['user_id'] != null) {
        emit(ForgetPasswordCheckingSuccessState(userId: response['user_id']));
      } else {
        emit(ForgetPasswordCheckingFailedState());
      }
    });
  }

  FutureOr<void> resetPasswordEvent(
      ResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ResetPasswordLoadingState());
    final data =
        await UserRepo().resetPassword(event.newPasswordData, event.userId);
    data.fold((error) {
      emit(ResetPasswordErrorState(message: error.message));
    }, (response) {
      emit(ResetPasswordSuccessState());
    });
  }
}
