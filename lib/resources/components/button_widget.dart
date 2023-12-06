import 'package:flutter/material.dart';
import 'package:user_side/resources/constants/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPress;

  const ButtonWidget({super.key, required this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 1,
      child: ElevatedButton(
        onPressed: onPress,
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
