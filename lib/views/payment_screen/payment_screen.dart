import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/payment/payment_bloc.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/data/get_it/get_it.dart';
import 'package:user_side/models/vehicle_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/fair_details.dart';
import 'package:user_side/resources/components/pickup_dropoff_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  Vehicle vehicle;
  final String startingDate;
  final String endingDate;
  var isChecked = ValueNotifier(false);
  PaymentScreen({
    super.key,
    required this.vehicle,
    required this.startingDate,
    required this.endingDate,
  });

  late int sgst = vehicle.price ~/ 14.ceil();
  late int cgst = sgst;
  late double totalAmount = vehicle.price + sgst + cgst;

  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  child: Image.network(
                    '${ApiUrls.baseUrl}/${vehicle.images[0]}',
                    fit: BoxFit.fill,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: dpadding),
                  child: const BackButtonWidget(),
                )
              ],
            ),
            SubTitleWidget(
                title:
                    "${vehicle.brand.toUpperCase()}  ${vehicle.name.toUpperCase()}",
                fontsize: 18),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SmallCarCardWidget(
            //         name: vehicle.transmission,
            //         asset: 'asset/svg/steering-wheel.svg'),
            //     SmallCarCardWidget(
            //         name: vehicle.model.toString(),
            //         asset: "asset/svg/settings.svg"),
            //     SmallCarCardWidget(
            //         name: vehicle.fuel, asset: "asset/svg/petrol.svg"),
            //     SmallCarCardWidget(
            //         name: vehicle.location,
            //         asset: "asset/svg/location-outline.svg")
            //   ],
            // ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PickupDropoffWidget(
                    title: 'Pickup',
                    location: vehicle.location,
                    date: startingDate),
                PickupDropoffWidget(
                    title: 'Dropoff',
                    location: vehicle.location,
                    date: endingDate),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubTitleWidget(title: 'Fair Details'),
                    FairDetailsRowWidget(
                        name: "Base Rate :", money: '₹ ${vehicle.price}'),
                    FairDetailsRowWidget(name: "SGST : 14 %", money: '₹ $sgst'),
                    FairDetailsRowWidget(name: "CGST : 14 %", money: '₹ $cgst'),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(thickness: 0.5)),
                    Row(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: isChecked,
                            builder: (context, value, _) {
                              return Checkbox(
                                value: value,
                                onChanged: (value) {
                                  isChecked.value = value ?? false;
                                },
                              );
                            }),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Wallet'),
                                Text('₹ ${globalUserModel.wallet ?? 0}')
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    FairDetailsRowWidget(
                        name: "Total Rental Amount", money: '₹ $totalAmount'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocConsumer<PaymentBloc, PaymentState>(
                        listener: (context, state) {
                          if (state is PaymentSuccessState) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ScreenParant()),
                                (route) => false);
                          } else if (state is PaymentFailedState) {
                            // ignore: void_checks
                            return topSnackbar(
                                context, 'Payment Failed', Colors.red);
                          } else if (state is PaymentErrorState) {
                            // ignore: void_checks
                            return topSnackbar(
                                context, state.message, Colors.red);
                          }
                        },
                        builder: (context, state) {
                          return ButtonWidget(
                              title: 'Book Now',
                              onPress: () => context.read<PaymentBloc>().add(
                                  PaymentInitialEvent(
                                      total: vehicle.price.toInt(),
                                      userId: vehicle.hostDetails.id,
                                      vehicleId: vehicle.id,
                                      pickup: vehicle.location,
                                      dropoff: vehicle.location,
                                      startDate: startingDate,
                                      endDate: endingDate,
                                      grandTotal: totalAmount.toInt())));
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
