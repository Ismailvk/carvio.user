import 'package:flutter/material.dart';

class FairDetailsRowWidget extends StatelessWidget {
  final String name;
  final String money;

  const FairDetailsRowWidget(
      {super.key, required this.name, required this.money});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(name), Text(money)]));
  }
}
