import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/data/netword/api_urls.dart';
import 'package:user_side/models/car_model.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/icon_svg_widget.dart';
import 'package:user_side/resources/components/list_empty_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/top_brand/details_screen.dart';

class TopBrandVehicleList extends StatefulWidget {
  final List<CarModel> carmodel;
  const TopBrandVehicleList({super.key, required this.carmodel});

  @override
  State<TopBrandVehicleList> createState() => _TopBrandVehicleListState();
}

class _TopBrandVehicleListState extends State<TopBrandVehicleList> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    if (widget.carmodel.isEmpty) {
      return const EmptyListWidget();
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: dpadding),
            child: Row(
              children: [
                const BackButtonWidget(),
                SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                Text('Vehicles', style: AppFonts.appbarTitle)
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.carmodel.length,
            itemBuilder: (context, index) {
              CarModel vehicle = widget.carmodel[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCarDetailsScreen(
                            vehicleData: vehicle,
                          ))),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CarouselSlider(
                                      items: vehicle.images
                                          .map((e) => Image.network(
                                                '${ApiUrls.baseUrl}/$e',
                                                fit: BoxFit.fill,
                                              ))
                                          .toList(),
                                      options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.19,
                                        onPageChanged: (index, reason) =>
                                            setState(() => activeIndex = index),
                                        viewportFraction: 1,
                                      ),
                                    ),
                                  )
                                ],
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
                                  count: vehicle.images.length),
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
                                  horizontal: 17, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(vehicle.brand.toUpperCase(),
                                          style: AppFonts.sansitaFont),
                                      Text('₹ ${vehicle.price}',
                                          style: AppFonts.sansitaFont)
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(vehicle.model.toString(),
                                      style: AppFonts.sansitaFontGrey),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const IconSvg(
                                          name:
                                              'asset/svg/auto_transmission.svg'),
                                      const SizedBox(width: 5),
                                      Text(vehicle.transmission,
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
                                      Text(vehicle.location,
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
          ),
        ],
      ),
    );
  }
}
