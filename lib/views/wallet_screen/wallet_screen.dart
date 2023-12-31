import 'package:flutter/material.dart';
import 'package:user_side/data/get_it/get_it.dart';
import 'package:user_side/resources/components/backbutton_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
                SizedBox(width: MediaQuery.of(context).size.width / 4),
                Text('Settings', style: AppFonts.appbarTitle)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.teal.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BALANCE :',
                      style: AppFonts.popinsHeading,
                    ),
                    Text(
                      "₹ ${globalUserModel.wallet.toString()}",
                      style: AppFonts.popinsHeading,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
