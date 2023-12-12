part of 'map_bloc.dart';

abstract class MapEvent {}

final class LocationSelectEvent extends MapEvent {
  LatLng location;
  LocationSelectEvent({required this.location});
}

final class LocationNamesShowEvent extends MapEvent {
  String searchValue;
  LocationNamesShowEvent({required this.searchValue});
}

final class OnSelectedLatlongLocation extends MapEvent {
  final LatLng newLocation;

  OnSelectedLatlongLocation({required this.newLocation});
}
