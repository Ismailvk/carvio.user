part of 'vehicle_bloc.dart';

abstract class VehicleEvent {}

final class FetchAvailableVehicleEvent extends VehicleEvent {
  final Map<String, String> checkingData;

  FetchAvailableVehicleEvent({required this.checkingData});
}

final class FetchVehicleEvent extends VehicleEvent {}
