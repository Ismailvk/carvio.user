import 'package:flutter/material.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_bar_main_screen.dart';
import 'package:user_side/views/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logincheck(context);
    return const Scaffold(
      body: Center(
        child: Text('CARVIO'),
      ),
    );
  }

  logincheck(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = SharedPref.instance.getToke();
    print(token);
    if (token != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CoustomNavBar()),
          (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => LoginScreen()),
          (route) => false);
    }
  }
}
