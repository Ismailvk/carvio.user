import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';

class EmailChangedSuccess extends StatelessWidget {
  const EmailChangedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              alignment: Alignment.topCenter,
              child: Lottie.asset('asset/lotties/emailSuccess.json'),
            ),
            Text('Success !!!', style: AppFonts.sansCaption),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              child: Text(
                'Successfully changed your password . please press the welcome button ',
                style: AppFonts.popins,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            ButtonWidget(
              title: 'Welcome',
              onPress: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScreenParant())),
            )
          ],
        ),
      ),
    );
  }
}
