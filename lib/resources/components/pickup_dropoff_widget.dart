import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

class PickupDropoffWidget extends StatelessWidget {
  final String title;
  final String location;
  final String date;

  const PickupDropoffWidget(
      {super.key,
      required this.title,
      required this.location,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 14,
              width: MediaQuery.of(context).size.width / 2.4,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  color: AppColors.carBackgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Text(title, textAlign: TextAlign.center),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 165,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('Location  : $location'),
                  Text('Date  : $date'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
