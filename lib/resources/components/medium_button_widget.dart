import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

class MediumButtonWidget extends StatelessWidget {
  final String title;

  const MediumButtonWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.primaryColor)),
        child: Text(title),
      ),
    );
  }
}
