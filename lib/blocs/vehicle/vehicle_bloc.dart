import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/models/car_model.dart';
import 'package:user_side/models/vehicle_model.dart';
import 'package:user_side/repositories/user_repo.dart';
part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial()) {
    on<FetchAvailableVehicleEvent>(fetchAvailableVehicle);
    on<FetchVehicleEvent>(fetchVehicleEvent);
    on<FetchAllVehicles>(fetchAllVehicle);
  }

  FutureOr<void> fetchAvailableVehicle(
      FetchAvailableVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(FetchAvailableVehicleLoadingState());
    final responseData =
        await UserRepo().putAvailableVehicle(event.checkingData);
    responseData.fold((error) {
      emit(FetchAvailableVehicleErrorState(message: error.message));
    }, (response) {
      if (response['message'] == 'Success') {
        emit(FetchVehicleSuccessState());
      } else {
        emit(FetchAvailableVehicleFailedState());
      }
    });
  }

  FutureOr<void> fetchVehicleEvent(
      FetchVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(FetchAvailableVehicleLoadingState());
    final responseData = await UserRepo().getAvailableVehicles();
    responseData.fold((error) {
      emit(FetchAvailableVehicleErrorState(message: error.message));
    }, (response) {
      final List vehicleList = response['vehicles'];
      List<VehicleModel> vehicleModel =
          vehicleList.map((e) => VehicleModel.fromJson(e)).toList();
      emit(FetchAvailableVehicleSuccessState(vehicleList: vehicleModel));
    });
  }

  FutureOr<void> fetchAllVehicle(
      FetchAllVehicles event, Emitter<VehicleState> emit) async {
    final response = await UserRepo().getAllVehicle();
    response.fold((error) {
      emit(FetchAllVehicleFailedState());
    }, (response) {
      final List vehicleList = response['vehicles'];
      List<CarModel> vehicleModel =
          vehicleList.map((e) => CarModel.fromJson(e)).toList();
      emit(FetchAllVehicleSuccessState(allVehicleList: vehicleModel));
    });
  }
}
