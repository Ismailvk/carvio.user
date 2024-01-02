import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/divider.dart';
import 'package:user_side/resources/components/row_text_widget.dart';
import 'package:user_side/resources/components/small_car_card_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class HistoryCompletedDetailsScreen extends StatefulWidget {
  final BookingModel bookingData;
  const HistoryCompletedDetailsScreen({super.key, required this.bookingData});

  @override
  State<HistoryCompletedDetailsScreen> createState() =>
      _HistoryCompletedDetailsScreenState();
}

class _HistoryCompletedDetailsScreenState
    extends State<HistoryCompletedDetailsScreen> {
  @override
  void initState() {
    super.initState();
    count = countDate(widget.bookingData.startDate, widget.bookingData.endDate);
  }

  int activeIndex = 0;
  int? count;

  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: CarouselSlider(
                  items: widget.bookingData.vehicle.images
                      .map((e) => Image.network(
                            '${ApiUrls.baseUrl}/$e',
                            fit: BoxFit.fill,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                    viewportFraction: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: dpadding),
                child: const BackButtonWidget(),
              ),
              Positioned(
                bottom: 5,
                left: MediaQuery.of(context).size.width / 2.5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: AnimatedSmoothIndicator(
                      effect: const WormEffect(
                          activeDotColor: Colors.teal,
                          dotHeight: 7,
                          dotWidth: 7),
                      activeIndex: activeIndex,
                      count: widget.bookingData.vehicle.images.length),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitleWidget(
                    title:
                        "${widget.bookingData.vehicle.brand.toUpperCase()}  ${widget.bookingData.vehicle.name.toUpperCase()}",
                    fontsize: 18),
                Text(widget.bookingData.total.toString(),
                    style: AppFonts.sansitaFontred)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.transmission,
                  asset: 'asset/svg/steering-wheel.svg'),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.model.toString(),
                  asset: "asset/svg/settings.svg"),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.fuel,
                  asset: "asset/svg/petrol.svg"),
              SmallCarCardWidget(
                  name: widget.bookingData.vehicle.location,
                  asset: "asset/svg/location-outline.svg")
            ],
          ),
          const SizedBox(height: 15),
          Rowwidget(heading: 'STATUS', data: widget.bookingData.status),
          Rowwidget(heading: 'DAYS', data: count.toString()),
          Rowwidget(
              heading: 'STARTING DATE', data: widget.bookingData.startDate),
          Rowwidget(heading: 'ENDING DATE', data: widget.bookingData.endDate),
          Rowwidget(
              heading: 'PICKUP LOCATION', data: widget.bookingData.pickup),
          Rowwidget(
              heading: 'DROPOFF LOCATION', data: widget.bookingData.dropoff),
          const DivederWidget(),
          Rowwidget(
              heading: 'GRAND TOTAL',
              data: widget.bookingData.grandTotal.toString()),
        ],
      ),
    );
  }

  int countDate(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    int diffrence = endDate.difference(startDate).inDays;
    return diffrence;
  }
}
