import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/blocs/user_data/user_data_bloc.dart';
import 'package:user_side/blocs/vehicle/vehicle_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/components/top_brands.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/active_car/active_car_details.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
import 'package:user_side/views/home_screen/view_more.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchBookingDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.sizeOf(context).height;
    context.read<VehicleBloc>().add(FetchAllVehicles());
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CARVIO',
                    style: GoogleFonts.tektur(
                        fontWeight: FontWeight.w500, fontSize: 20)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: globalUserModel?.profile == null
                      ? Image.asset(
                          'asset/images/user copy.png',
                          height: MediaQuery.of(context).size.width * 0.09,
                          width: MediaQuery.of(context).size.width * 0.09,
                        )
                      : Image.network(
                          '${ApiUrls.baseUrl}/${globalUserModel?.profile}',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    if (state is GetUserDataSuccessState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hi, ${state.userModel.name}',
                                  style: AppFonts.ibmsans),
                              Text('Welcome !!!!', style: AppFonts.popins)
                            ],
                          ),
                          // Text('₹ ${state.userModel.wallet ?? 0}',
                          //     style: AppFonts.ibmsansGrey)
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is FetchBookingDataSuccessState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SubTitleWidget(title: 'Active Car'),
                    state.activeList.length > 1
                        ? GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ViewMoreScree(
                                        vehicle: state.activeList))),
                            child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text('View more',
                                    style:
                                        GoogleFonts.cairo(color: Colors.blue))),
                          )
                        : const SizedBox()
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FetchBookingDataSuccessState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      if (state.activeList.isEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightGrey,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          height: heigth / 2.99,
                          child: Center(
                              child: Column(
                            children: [
                              Lottie.asset('asset/lotties/sEQEXLmUqi.json',
                                  height:
                                      MediaQuery.of(context).size.height / 3.5),
                              Text(
                                "You haven't active vehicle",
                                style: AppFonts.popins,
                              )
                            ],
                          )),
                        );
                      }
                      BookingModel vehicle = state.activeList[0];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ActiveCarDetailsScreen(
                                  vehicleData: vehicle)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.lightGrey,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            height: heigth / 2.99,
                            child: state.activeList.isNotEmpty
                                ? Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.black,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${ApiUrls.baseUrl}/${vehicle.vehicle.images[0]}"),
                                                fit: BoxFit.cover)),
                                        height: heigth / 4.3,
                                        width: heigth / 2.2,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            height: heigth / 12,
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                1.7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    "${vehicle.vehicle.brand.toUpperCase()} ${vehicle.vehicle.name.toUpperCase()}",
                                                    style:
                                                        AppFonts.sansitaFont),
                                                Text("₹ ${vehicle.grandTotal}",
                                                    style: AppFonts
                                                        .sansitaFontred),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 40),
                                            child: const Row(
                                              children: [
                                                Icon(Icons.circle,
                                                    color: Colors.green,
                                                    size: 15),
                                                SizedBox(width: 5),
                                                Text(" ACTIVE")
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : Center(
                                    child: Column(
                                    children: [
                                      Lottie.asset(
                                          'asset/lotties/sEQEXLmUqi.json',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5),
                                      Text(
                                        "You haven't active vehicle",
                                        style: AppFonts.popins,
                                      )
                                    ],
                                  ))),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SubTitleWidget(title: 'Top Brands'),
          BlocBuilder<VehicleBloc, VehicleState>(
            buildWhen: (previous, current) =>
                current is! FetchAvailableVehicleSuccessState,
            builder: (context, state) {
              if (state is FetchAllVehicleSuccessState) {
                return TopBrandsWidget(carmodel: state.allVehicleList);
              }
              return const SizedBox.shrink();
            },
          )
        ],
      )),
    );
  }
}
