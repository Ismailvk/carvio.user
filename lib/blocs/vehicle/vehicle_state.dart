part of 'vehicle_bloc.dart';

abstract class VehicleState {}

final class VehicleInitial extends VehicleState {}

final class FetchAvailableVehicleSuccessState extends VehicleState {
  List<Vehicle> vehicleList;
  FetchAvailableVehicleSuccessState({required this.vehicleList});
}

final class VehicleFetchSuccessState extends VehicleState {}

final class FetchAvailableVehicleFailedState extends VehicleState {}

final class FetchAvailableVehicleErrorState extends VehicleState {
  final String message;

  FetchAvailableVehicleErrorState({required this.message});
}

final class FetchVehicleSuccessState extends VehicleState {}

final class FetchVehicleFailedState extends VehicleState {}
