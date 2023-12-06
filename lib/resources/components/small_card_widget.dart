import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

class SmallCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const SmallCardWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.16,
      width: MediaQuery.of(context).size.width * 0.55,
      child: Card(
        color: AppColors.cardGreyColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
