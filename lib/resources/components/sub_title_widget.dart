import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitleWidget extends StatelessWidget {
  final String title;
  const SubTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      child: Text(
        title,
        style: GoogleFonts.inriaSans(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
