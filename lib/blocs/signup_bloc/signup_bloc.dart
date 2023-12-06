import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonClickEvent>(signupButtonClickEvent);
    on<OtpButtonClickedEvent>(otpButtonClickedEvent);
  }

  FutureOr<void> signupButtonClickEvent(
      SignupButtonClickEvent event, Emitter<SignupState> emit) async {
    final data = await UserRepo().signUpUser(event.userData);
    data.fold(
      (error) {
        emit(SignupErrorState(message: error.message));
      },
      (response) {
        emit(SignupSuccessState());
      },
    );
  }

  FutureOr<void> otpButtonClickedEvent(
      OtpButtonClickedEvent event, Emitter<SignupState> emit) async {
    String otpPin = '${event.pin1}${event.pin2}${event.pin3}${event.pin4}';
    int signupOtp = int.tryParse(otpPin)!;
    Map<String, dynamic> otp = {'otp': signupOtp};
    final data = await UserRepo().signupOtp(otp);
    data.fold((error) {
      emit(OtpErrorState(message: error.message));
    }, (response) {
      final token = response['token'];
      SharedPref.instance.storeToken(token);
      emit(OtpSuccessState());
    });
  }
}
