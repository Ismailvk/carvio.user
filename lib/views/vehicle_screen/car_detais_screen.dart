import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/vehicle_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/medium_button_widget.dart';
import 'package:user_side/resources/components/side_heading_row_widget.dart';
import 'package:user_side/resources/components/small_car_card_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/payment_screen/payment_screen.dart';

// ignore: must_be_immutable
class CarDetailsScreen extends StatefulWidget {
  final Vehicle vehicleData;
  final String startingDate;
  final String endingDate;
  const CarDetailsScreen({
    super.key,
    required this.vehicleData,
    required this.startingDate,
    required this.endingDate,
  });

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Image.network(
                    '${ApiUrls.baseUrl}/${widget.vehicleData.images[0]}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: dpadding),
                child: const BackButtonWidget(),
              ),
            ],
          ),
          SideHeadingRowWidget(
            title: widget.vehicleData.brand,
            secondTitle: "₹ ${widget.vehicleData.price}",
            color: AppColors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallCarCardWidget(
                  name: widget.vehicleData.transmission,
                  asset: 'asset/svg/steering-wheel.svg'),
              SmallCarCardWidget(
                  name: widget.vehicleData.model.toString(),
                  asset: "asset/svg/settings.svg"),
              SmallCarCardWidget(
                  name: widget.vehicleData.fuel, asset: "asset/svg/petrol.svg"),
              SmallCarCardWidget(
                  name: widget.vehicleData.location,
                  asset: "asset/svg/location-outline.svg")
              // SmallCardWidget(
              //     title: 'Transmission',
              //     subtitle: widget.vehicleData.transmission),
              // SmallCardWidget(
              //     title: 'Fuel', subtitle: widget.vehicleData.fuel),
              // const SmallCardWidget(title: 'Seat', subtitle: '5'),
            ],
          ),
          const SubTitleWidget(title: 'Renter'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              color: AppColors.lightGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: widget.vehicleData.hostDetails.profile != null
                          ? Image.network(
                              '${ApiUrls.baseUrl}/${widget.vehicleData.hostDetails.profile}',
                              height: MediaQuery.of(context).size.height / 13,
                              width: MediaQuery.of(context).size.width / 6,
                            )
                          : Image.asset(
                              'asset/images/person2.jpg',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )),
                  const SizedBox(width: 20),
                  Text(
                    widget.vehicleData.hostDetails.name,
                    style: AppFonts.sansitaFont,
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black.withOpacity(0.3),
                    child: const Icon(Icons.call),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CarouselSlider(
              items: widget.vehicleData.images
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${ApiUrls.baseUrl}/$e',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 4,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 7),
                  child:
                      Text('₹ 2000', style: GoogleFonts.ledger(fontSize: 22)),
                ),
                const Spacer(),
                MediumButtonWidget(
                  title: 'Book Now',
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                              vehicle: widget.vehicleData,
                              startingDate: widget.startingDate,
                              endingDate: widget.endingDate,
                            )));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
