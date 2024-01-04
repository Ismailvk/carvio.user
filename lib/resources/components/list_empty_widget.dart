import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dpadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: dpadding),
            child: Row(
              children: [
                const BackButtonWidget(),
                SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                Text('Vehicles', style: AppFonts.appbarTitle)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Lottie.asset('asset/lotties/manLottie.json'),
                  Text('No vehicle found on this location',
                      style: AppFonts.sansitaFontBlack)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
