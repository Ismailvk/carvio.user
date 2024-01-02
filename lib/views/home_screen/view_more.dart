import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/booking_model.dart';
import 'package:user_side/resources/components/appbar.dart';
import 'package:user_side/resources/components/icon_svg_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/vehicle_screen/history_completed_screen.dart';

// ignore: must_be_immutable
class ViewMoreScree extends StatefulWidget {
  List<BookingModel> vehicle;
  ViewMoreScree({super.key, required this.vehicle});

  @override
  State<ViewMoreScree> createState() => _ViewMoreScreeState();
}

class _ViewMoreScreeState extends State<ViewMoreScree> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const AppbarBckbutton(text: 'Active vehicles'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: widget.vehicle.length,
          itemBuilder: (context, index) {
            BookingModel list = widget.vehicle[index];

            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      HistoryCompletedDetailsScreen(bookingData: list))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CarouselSlider(
                              items: list.vehicle.images
                                  .map((e) => ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '${ApiUrls.baseUrl}/$e',
                                          fit: BoxFit.cover,
                                        ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: AnimatedSmoothIndicator(
                                effect: const WormEffect(
                                    activeDotColor: Colors.teal,
                                    dotHeight: 7,
                                    dotWidth: 7),
                                activeIndex: activeIndex,
                                count: list.vehicle.images.length),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.19,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(list.vehicle.name.toUpperCase(),
                                        style: AppFonts.sansitaFont),
                                    Text('₹ ${list.vehicle.price}',
                                        style: AppFonts.sansitaFont)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    '${list.vehicle.brand.toUpperCase()}  ${list.vehicle.model.toString()}',
                                    style: AppFonts.sansitaFontGrey),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const IconSvg(
                                        name:
                                            'asset/svg/auto_transmission.svg'),
                                    const SizedBox(width: 5),
                                    Text(
                                        list.vehicle.transmission.toUpperCase(),
                                        style: AppFonts.sansitaFontGrey)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const IconSvg(
                                      name: 'asset/svg/location_on.svg',
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(list.vehicle.location,
                                        style: AppFonts.sansitaFontGrey)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    ));
  }
}
