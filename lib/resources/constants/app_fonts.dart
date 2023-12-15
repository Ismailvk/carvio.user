import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle sansitaFont = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 17, color: Colors.black));

  static TextStyle sansitaFontGrey = GoogleFonts.sansita(
      textStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600));

  static TextStyle appbarSansitaFont = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 20, color: Colors.black));

  static TextStyle sansitaFontBlack = GoogleFonts.sansita(
      textStyle: const TextStyle(fontSize: 16, color: Colors.black));
}
