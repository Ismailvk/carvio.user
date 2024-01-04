import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_side/blocs/forget_password/forget_password_bloc.dart';
import 'package:user_side/blocs/login_bloc/login_bloc.dart';
import 'package:user_side/blocs/map_bloc/map_bloc.dart';
import 'package:user_side/blocs/payment/payment_bloc.dart';
import 'package:user_side/blocs/signup_bloc/signup_bloc.dart';
import 'package:user_side/blocs/user/user_bloc.dart';
import 'package:user_side/blocs/user_data/user_data_bloc.dart';
import 'package:user_side/blocs/vehicle/vehicle_bloc.dart';
import 'package:user_side/data/shared_preference/shared_prefence.dart';
import 'package:user_side/firebase_options.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.instance.initStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataBloc>(create: (context) => UserDataBloc()),
        BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<UserDataBloc>())),
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(context.read<UserBloc>())),
        BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(context.read<UserBloc>())),
        BlocProvider<MapBloc>(create: (context) => MapBloc()),
        BlocProvider<VehicleBloc>(create: (context) => VehicleBloc()),
        BlocProvider<ForgetPasswordBloc>(
            create: (context) => ForgetPasswordBloc()),
        BlocProvider<PaymentBloc>(create: (context) => PaymentBloc()),
        // BlocProvider<ProfileEditBloc>(create: (context) => ProfileEditBloc()),
      ],
      child: MaterialApp(
        title: 'Carnova User',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor)),
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black)),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
