import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/vehicle_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/medium_button_widget.dart';
import 'package:user_side/resources/components/side_heading_row_widget.dart';
import 'package:user_side/resources/components/small_card_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/payment_screen/payment_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final Vehicle vehicleData;
  final String startingDate;
  final String endingDate;
  const CarDetailsScreen(
      {super.key,
      required this.vehicleData,
      required this.startingDate,
      required this.endingDate});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  List item = [
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.carBackgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  height: 330,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackButtonWidget(),
                      CarouselSlider(
                        items: widget.vehicleData.images
                            .map((e) => Image.network(
                                  '${ApiUrls.baseUrl}/$e',
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                          viewportFraction: 1,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: AnimatedSmoothIndicator(
                      effect: const WormEffect(dotHeight: 10, dotWidth: 10),
                      activeIndex: activeIndex,
                      count: item.length),
                )
              ],
            ),
            SideHeadingRowWidget(
              title: widget.vehicleData.brand,
              secondTitle: "₹ ${widget.vehicleData.price}",
              color: AppColors.red,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SmallCardWidget(
                        title: 'Transmission',
                        subtitle: widget.vehicleData.transmission),
                    SmallCardWidget(
                        title: 'Fuel', subtitle: widget.vehicleData.fuel),
                    const SmallCardWidget(title: 'Seat', subtitle: '5'),
                  ],
                ),
              ),
            ),
            const SubTitleWidget(title: 'Renter'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Icon(Icons.favorite_border, size: 40),
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
      ),
    );
  }
}
