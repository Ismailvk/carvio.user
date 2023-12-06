import 'package:flutter/material.dart';

class SideHeadingRowWidget extends StatelessWidget {
  final String title;
  final String secondTitle;
  final Color color;
  const SideHeadingRowWidget(
      {super.key,
      required this.title,
      required this.secondTitle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            secondTitle,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
