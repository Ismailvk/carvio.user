import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_side/resources/components/sub_title_widget.dart';
import 'package:user_side/resources/constants/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'asset/svg/dashboard.svg',
                    height: MediaQuery.of(context).size.width * 0.07,
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.16),
                  SvgPicture.asset(
                    'asset/svg/location-outline.svg',
                    height: MediaQuery.of(context).size.width * 0.06,
                    width: MediaQuery.of(context).size.width * 0.06,
                  ),
                  const Text('Kondotty/INDIA'),
                  const Icon(Icons.expand_more),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'asset/images/person2.jpg',
                      height: MediaQuery.of(context).size.width * 0.09,
                      width: MediaQuery.of(context).size.width * 0.09,
                    ),
                  )
                ],
              ),
            ),
            const SubTitleWidget(title: 'Active Car'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 230,
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('asset/images/rangerrover.png'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ranger Rover'),
                          Text(
                            '₹ 20000',
                            style: TextStyle(color: AppColors.red),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
