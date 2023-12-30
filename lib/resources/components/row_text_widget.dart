import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class Rowwidget extends StatelessWidget {
  final String heading;
  final String data;
  const Rowwidget({super.key, required this.heading, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$heading  :',
            style: AppFonts.popins,
          ),
          Text(
            data.toUpperCase(),
            style: AppFonts.popins,
          )
        ],
      ),
    );
  }
}
