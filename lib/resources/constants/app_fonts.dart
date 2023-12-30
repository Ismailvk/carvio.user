import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/resources/constants/app_color.dart';

class AppFonts {
  static TextStyle sansitaFont = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 17, color: Colors.black));

  static TextStyle sansitaFontred = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 17, color: Colors.red));

  static TextStyle sansitaFontWhite = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 17, color: Colors.white));

  static TextStyle sansitaFontGrey = GoogleFonts.sansita(
      textStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600));

  static TextStyle appbarSansitaFont = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 20, color: Colors.black));

  static TextStyle sansitaFontBlack = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 16, color: Colors.black));

  static TextStyle popins =
      GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey));

  static TextStyle popinsSub =
      GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black));

  static TextStyle popinsGreen = GoogleFonts.poppins(
      textStyle: const TextStyle(color: Colors.green, fontSize: 17));

  static TextStyle popinsSubRed =
      GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.red));

  static TextStyle popinsHeading =
      GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 17));

  static TextStyle sansCaption = GoogleFonts.ptSansCaption(
      fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 24);

  static TextStyle normal =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle appbarTitle =
      GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600);
}
