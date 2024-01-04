import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_side/blocs/user_data/user_data_bloc.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/models/car_model.dart';
import 'package:user_side/models/user_model.dart';
import 'package:user_side/repositories/user_repo.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserModel userModel;
  late UserDataBloc userDataBloc;
  UserBloc(this.userDataBloc) : super(UserInitial()) {
    on<FetchUserDataEvent>(fetchUserData);
    on<ResetPasswordEvent>(resetPassword);
    on<FetchBookingDataEvent>(fetchBookingData);
  }

  List<BookingModel> completedList = [];
  List<BookingModel> upComingList = [];
  List<BookingModel> todayList = [];
  List<CarModel> vehicleModel = [];

  FutureOr<void> fetchUserData(
      FetchUserDataEvent event, Emitter<UserState> emit) async {
    final data = await UserRepo().fetchUserData(event.token);
    data.fold((error) {
      emit(FetchUserDataErrorState(message: error.message));
    }, (response) {
      if (response != null) {
        userModel = UserModel.fromJson(response);
        globalUserModel = userModel;
        userDataBloc.add(FetchUserData(userModel: userModel));
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

  FutureOr<void> fetchBookingData(
      FetchBookingDataEvent event, Emitter<UserState> emit) async {
    final responseData = await UserRepo().getBookingData();
    DateTime currentDate = DateTime.now();
    DateFormat('yyyy-MM-dd').format(currentDate);

    responseData.fold((error) {
      emit(FetchBookingDataErrorState(message: error.message));
    }, (response) {
      if (response != null) {
        final rawList = response as List;
        final bookingList =
            rawList.map((e) => BookingModel.fromJson(e)).toList();

        todayList = bookingList.where((element) {
          final startDate = DateTime.parse(element.startDate);
          final endDate = DateTime.parse(element.endDate);
          return startDate.isBefore(currentDate) &&
              endDate.isAfter(currentDate);
        }).toList();

        completedList = bookingList.where((element) {
          final endDate = DateTime.parse(element.endDate);
          return endDate.isBefore(currentDate);
        }).toList();

        upComingList = bookingList.where((element) {
          final endDate = DateTime.parse(element.endDate);
          return endDate.isAfter(currentDate);
        }).toList();

        emit(FetchBookingDataSuccessState(
            completeList: completedList,
            upcomingList: upComingList,
            activeList: todayList));
      } else {
        emit(FetchBookingDataFailedState());
      }
    });
  }
}
