import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/models/vehicle_model.dart';
import 'package:user_side/repositories/user_repo.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial()) {
    on<FetchAvailableVehicleEvent>(fetchAvailableVehicle);
    on<FetchVehicleEvent>(fetchVehicleEvent);
  }

  FutureOr<void> fetchAvailableVehicle(
      FetchAvailableVehicleEvent event, Emitter<VehicleState> emit) async {
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
    final responseData = await UserRepo().getAvailableVehicles();
    responseData.fold((error) {
      emit(FetchAvailableVehicleErrorState(message: error.message));
    }, (response) {
      final List vehicleList = response['vehicles'];
      List<Vehicle> vehicleModel =
          vehicleList.map((e) => Vehicle.fromJson(e)).toList();
      emit(FetchAvailableVehicleSuccessState(vehicleList: vehicleModel));
    });
  }
}
