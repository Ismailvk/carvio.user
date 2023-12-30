import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_side/blocs/map_bloc/map_bloc.dart';
import 'package:user_side/blocs/vehicle/vehicle_bloc.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/utils/map_box.dart';
import 'package:user_side/views/vehicle_screen/vehicle_list_screen.dart';

// ignore: must_be_immutable
class BookingMapScreen extends StatelessWidget {
  String endingDate;
  String startingDate;
  BookingMapScreen({
    super.key,
    required this.endingDate,
    required this.startingDate,
  });

  MapController mapController = MapController();
  LatLng latlong = const LatLng(9.931233, 76.267303);
  LatLng? selectedLatLng;
  var searchResults = [];
  String? locationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocConsumer<MapBloc, MapState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is MapLocationChangeSuccessState) {
                  return mapLocation(mapController, state.newLatlong, context);
                } else if (state is OnSelectedLatlongLocationSuccessState) {
                  return mapLocation(
                      mapController, state.selectedLocation, context);
                }
                return mapLocation(mapController, latlong, context);
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Card(
                child: TextField(
                  onSubmitted: (value) async {
                    context
                        .read<MapBloc>()
                        .add(LocationNamesShowEvent(searchValue: value));
                  },
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Search Your Location',
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    contentPadding: EdgeInsets.all(15),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8 + 60,
              left: 20,
              right: 20,
              child: BlocConsumer<MapBloc, MapState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LocationNamesShowSuccessState) {
                    searchResults = state.locationList;
                    return Visibility(
                      visible: searchResults.isNotEmpty,
                      child: SizedBox(
                        height: 300,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  child: ListTile(
                                    leading: const Icon(Icons.search),
                                    horizontalTitleGap: 0,
                                    title: Text(
                                      searchResults[index]['placeName']
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onTap: () {
                                      String fullPlaceName =
                                          searchResults[index]['placeName'];
                                      String placeName =
                                          MapBoxHelper.getOnlyFirstName(
                                              fullPlaceName);
                                      locationName = placeName;
                                      // mapController.place.value = placeName;
                                      final newlatlong = LatLng(
                                        searchResults[index]['latitude'],
                                        searchResults[index]['longitude'],
                                      );
                                      context.read<MapBloc>().add(
                                          OnSelectedLatlongLocation(
                                              newLocation: newlatlong));
                                      mapController.move(latlong, 15);
                                      searchResults.clear();
                                    },
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount: searchResults.length),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
            Positioned(
              left: 40,
              bottom: 10,
              child: BlocListener<VehicleBloc, VehicleState>(
                listener: (context, state) {
                  if (state is FetchVehicleSuccessState) {
                    context.read<VehicleBloc>().add(FetchVehicleEvent());
                  } else if (state is FetchAvailableVehicleErrorState) {
                    topSnackbar(context, state.message, AppColors.red);
                  } else if (state is FetchAvailableVehicleFailedState) {
                    topSnackbar(context, "Something Went Wrong", AppColors.red);
                  }
                  if (state is FetchAvailableVehicleSuccessState) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VehicleListScreen(
                          startingDate: startingDate,
                          endingDate: endingDate,
                        ),
                      ),
                    );
                  }
                },
                child: ButtonWidget(
                  title: 'Check Availability',
                  onPress: () {
                    checkingVehicle(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  checkingVehicle(BuildContext context) {
    if (locationName == null || locationName!.isEmpty) {
      topSnackbar(context, "Choose Your Location", AppColors.red);
    } else if (locationName!.isNotEmpty) {
      Map<String, String> checkingData = {
        "startDate": startingDate,
        "endDate": endingDate,
        "pickup": locationName!,
        "dropoff": locationName!,
      };
      context
          .read<VehicleBloc>()
          .add(FetchAvailableVehicleEvent(checkingData: checkingData));
    }
  }
}

Widget mapLocation(mapController, latlong, BuildContext context) {
  return FlutterMap(
    mapController: mapController,
    options: MapOptions(
      initialCenter: latlong,
      initialZoom: 14,
      onTap: (tapPosition, point) {
        print('tapped');
        context.read<MapBloc>().add(LocationSelectEvent(location: point));
      },
    ),
    children: [
      TileLayer(
        urlTemplate:
            "https://api.mapbox.com/styles/v1/ismailvk/clp9licsc002201po1gh6bjt9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXNtYWlsdmsiLCJhIjoiY2xwOWtvZjF5MDM2dTJpcWlndHJ1Mnh0dyJ9.plsEL1xGKiKwrCuP36uc5Q",
        additionalOptions: const {
          "accessToken":
              "pk.eyJ1IjoiaXNtYWlsdmsiLCJhIjoiY2xwOWtvZjF5MDM2dTJpcWlndHJ1Mnh0dyJ9.plsEL1xGKiKwrCuP36uc5Q",
          "id": "mapbox.mapbox-streets-v8"
        },
      ),
      MarkerLayer(alignment: Alignment.center, markers: [
        Marker(
          height: 100,
          width: 100,
          point: latlong,
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 35,
          ),
        )
      ])
    ],
  );
}
