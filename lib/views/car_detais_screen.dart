import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/components/medium_button_widget.dart';
import 'package:user_side/resources/components/side_heading_row_widget.dart';
import 'package:user_side/resources/components/small_card_widget.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  List items = [
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
    Image.asset('asset/images/rangerrover.png'),
  ];

  int activeIndex = 0;
  int cardIndex = 0;

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
                        items: [
                          Image.asset('asset/images/rangerrover.png',
                              fit: BoxFit.cover),
                          Image.asset('asset/images/rangerrover.png',
                              fit: BoxFit.cover),
                          Image.asset('asset/images/rangerrover.png',
                              fit: BoxFit.cover),
                        ],
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
                      count: items.length),
                )
              ],
            ),
            const SideHeadingRowWidget(
              title: 'Rnger Rover',
              secondTitle: "₹ 20000",
              color: AppColors.red,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SmallCardWidget(
                        title: 'Transmission', subtitle: 'Automatic'),
                    SmallCardWidget(title: 'Fuel', subtitle: 'Petrol'),
                    SmallCardWidget(title: 'Seat', subtitle: '5'),
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
                    child: Image.asset(
                      'asset/images/person2.jpg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text('Anna Jhon'),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black.withOpacity(0.3),
                    child: const Icon(Icons.call),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Icon(Icons.favorite_border, size: 40),
                  ),
                  Spacer(),
                  MediumButtonWidget(title: 'Book Now')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
