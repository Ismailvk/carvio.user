import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/resources/constants/app_color.dart';

SnackBar customSnackbar(context, bool error, String messege) {
  return SnackBar(
    content: Text(
      messege,
      style: GoogleFonts.poppins(),
    ),
    backgroundColor: error ? AppColors.green : CupertinoColors.destructiveRed,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}

topSnackbar(BuildContext context, String message, Color color) {
  return Flushbar(
    message: message,
    icon: const Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.white,
    ),
    margin: const EdgeInsets.all(6.0),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(12),
    duration: const Duration(seconds: 3),
    leftBarIndicatorColor: Colors.black,
    backgroundColor: color,
  ).show(context);
}
