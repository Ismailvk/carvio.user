import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/utils/custom_snackbar.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
import 'package:user_side/views/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    logincheck(context);
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is FetchUserDataSuccessState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ScreenParant()));
          } else if (state is FetchUserDataErrorState) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else if (state is FetchUserDataFailedState) {
            topSnackbar(context, 'Please login your account', AppColors.red);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        child: const Center(
          child: Text('CARVIO'),
        ),
      ),
    );
  }

  logincheck(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = SharedPref.instance.getToke();
    print(token);
    if (token != null) {
      // ignore: use_build_context_synchronously
      context.read<UserBloc>().add(FetchUserDataEvent(token: token));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (builder) => LoginScreen()),
          (route) => false);
    }
  }
}
