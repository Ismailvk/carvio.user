import 'package:flutter/material.dart';

class DivederWidget extends StatelessWidget {
  const DivederWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Divider(thickness: 1),
    );
  }
}
