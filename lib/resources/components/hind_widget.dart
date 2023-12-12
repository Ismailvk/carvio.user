import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HindTextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final double left;
  final double top;
  final bool isBold;
  const HindTextWidget(
      {super.key,
      required this.isBold,
      required this.text,
      required this.size,
      required this.color,
      required this.left,
      required this.top});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top),
      child: Text(
        text,
        style: GoogleFonts.hind(
            color: color,
            fontSize: size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
