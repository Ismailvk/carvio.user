import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class ListTileWidget extends StatelessWidget {
  final String imageString;
  final String title;
  final bool? islogout;
  const ListTileWidget(
      {super.key,
      required this.imageString,
      required this.title,
      this.islogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: SvgPicture.asset(imageString,
            height: 25,
            color: islogout == true ? Colors.red : AppColors.primaryColor),
        title: Text(title,
            style:
                islogout == true ? AppFonts.popinsSubRed : AppFonts.popinsSub),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: islogout == true ? Colors.red : AppColors.primaryColor,
        ),
      ),
    );
  }
}
