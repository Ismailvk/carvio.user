import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_side/utils/map_box.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<LocationSelectEvent>(locationSelectEvent);
    on<LocationNamesShowEvent>(locationNamesShowEvent);
    on<OnSelectedLatlongLocation>(onSelectedLatlongLocation);
  }

  FutureOr<void> locationSelectEvent(
      LocationSelectEvent event, Emitter<MapState> emit) {
    emit(MapLocationChangeSuccessState(newLatlong: event.location));
  }

  FutureOr<void> locationNamesShowEvent(
      LocationNamesShowEvent event, Emitter<MapState> emit) async {
    List response = await MapBoxHelper.getSearchResults(event.searchValue);
    // ignore: unnecessary_null_comparison
    if (response.isNotEmpty) {
      emit(LocationNamesShowSuccessState(locationList: response));
    } else {
      emit(LoactionNamesShowFailedState());
    }
  }

  FutureOr<void> onSelectedLatlongLocation(
      OnSelectedLatlongLocation event, Emitter<MapState> emit) {
    emit(OnSelectedLatlongLocationSuccessState(
        selectedLocation: event.newLocation));
  }
}
