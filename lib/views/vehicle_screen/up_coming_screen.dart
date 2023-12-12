import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/resources/components/icon_svg_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  List items = [
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CarouselSlider(
                            items: [
                              Image.asset(
                                'asset/images/rangerrover.png',
                                fit: BoxFit.fill,
                                height: 130,
                                width: 150,
                              ),
                              Image.asset(
                                'asset/images/rangerrover.png',
                                fit: BoxFit.fill,
                                height: 130,
                                width: 150,
                              ),
                              Image.asset(
                                'asset/images/rangerrover.png',
                                fit: BoxFit.fill,
                                height: 130,
                                width: 150,
                              ),
                            ],
                            options: CarouselOptions(
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index),
                              viewportFraction: 1,
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
                          count: items.length),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('BMW E6', style: AppFonts.sansitaFont),
                              Text('₹ 2000', style: AppFonts.sansitaFont)
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('2018', style: AppFonts.sansitaFontGrey),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const IconSvg(
                                  name: 'asset/svg/auto_transmission.svg'),
                              const SizedBox(width: 5),
                              Text('Automatic', style: AppFonts.sansitaFontGrey)
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
                              Text('Kondotty', style: AppFonts.sansitaFontGrey)
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
      ),
    );
  }
}
