import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/login_bloc/login_bloc.dart';
import 'package:user_side/blocs/signup_bloc/signup_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.initStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SignupBloc>(create: (context) => SignupBloc()),
      ],
      child: MaterialApp(
        title: 'Carnova User',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor)),
          appBarTheme: const AppBarTheme(color: Colors.white),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
