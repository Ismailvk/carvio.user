import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/constants/app_fonts.dart';
import 'package:user_side/views/forget_password_screen.dart/new_password_scree.dart';

class FoundEmailScreen extends StatelessWidget {
  final String userId;
  const FoundEmailScreen({super.key, required this.userId});

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
                'Please check your email for create a new password or click the New password button',
                style: AppFonts.popins,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6),
            ButtonWidget(
              title: 'Create new password',
              onPress: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewPasswordScreen(userId: userId))),
            )
          ],
        ),
      ),
    );
  }
}
