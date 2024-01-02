import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/row_text_widget.dart';
import 'package:user_side/resources/components/side_heading_row_widget.dart';
import 'package:user_side/resources/components/small_car_card_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';

class ActiveCarDetailsScreen extends StatefulWidget {
  final BookingModel vehicleData;
  const ActiveCarDetailsScreen({super.key, required this.vehicleData});

  @override
  State<ActiveCarDetailsScreen> createState() => _ActiveCarDetailsScreenState();
}

class _ActiveCarDetailsScreenState extends State<ActiveCarDetailsScreen> {
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
                    '${ApiUrls.baseUrl}/${widget.vehicleData.vehicle.images[0]}',
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
            title: widget.vehicleData.vehicle.brand,
            secondTitle: "₹ ${widget.vehicleData.vehicle.price}",
            color: AppColors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallCarCardWidget(
                  name: widget.vehicleData.vehicle.transmission,
                  asset: 'asset/svg/steering-wheel.svg'),
              SmallCarCardWidget(
                  name: widget.vehicleData.vehicle.model.toString(),
                  asset: "asset/svg/settings.svg"),
              SmallCarCardWidget(
                  name: widget.vehicleData.vehicle.fuel,
                  asset: "asset/svg/petrol.svg"),
              SmallCarCardWidget(
                  name: widget.vehicleData.vehicle.location,
                  asset: "asset/svg/location-outline.svg")
            ],
          ),
          Rowwidget(heading: 'STATUS', data: widget.vehicleData.status),
          Rowwidget(
              heading: 'STARTING DATE', data: widget.vehicleData.startDate),
          Rowwidget(heading: 'ENDING DATE', data: widget.vehicleData.endDate),
          Rowwidget(
              heading: 'PICKUP LOCATION', data: widget.vehicleData.pickup),
          const DivederWidget(),
          Rowwidget(
              heading: 'GRAND TOTAL',
              data: widget.vehicleData.grandTotal.toString()),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CarouselSlider(
              items: widget.vehicleData.vehicle.images
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
                height: MediaQuery.of(context).size.height / 5,
                autoPlay: true,
                viewportFraction: 0.7,
                onPageChanged: (index, reason) {
                  setState(() => activeIndex = index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
