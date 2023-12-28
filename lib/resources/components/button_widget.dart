import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPress;
  bool? isColor;

  ButtonWidget({super.key, required this.title, this.onPress, this.isColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStatePropertyAll(isColor == true
                ? AppColors.carBackgroundColor
                : AppColors.primaryColor)),
        child: Text(title),
      ),
    );
  }
}
