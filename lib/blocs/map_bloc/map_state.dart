part of 'map_bloc.dart';

abstract class MapState {}

final class MapInitial extends MapState {}

final class MapLocationChangeSuccessState extends MapState {
  LatLng newLatlong;
  MapLocationChangeSuccessState({required this.newLatlong});
}

final class MapLocationChangeFailedState extends MapState {}

final class LocationNamesShowSuccessState extends MapState {
  List locationList;
  LocationNamesShowSuccessState({required this.locationList});
}

final class LoactionNamesShowFailedState extends MapState {}

final class OnSelectedLatlongLocationSuccessState extends MapState {
  final LatLng selectedLocation;

  OnSelectedLatlongLocationSuccessState({required this.selectedLocation});
}

final class OnSelectedLatlongLocationFailedState extends MapState {}
