import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/blocs/login_bloc/login_bloc.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/bottom_navbar_screen/bottom_navigation_bar.dart';
import 'package:user_side/views/signup_screen/signup_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/carback1.jpeg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.appgrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Welcome back to',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' CARVIO.',
                            style: GoogleFonts.poppins(
                                color: AppColors.primaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'You\'ve been missed!',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: emailController,
                        validator: (value) => Validation.isEmail(value!),
                        isSufix: false,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        validator: (value) =>
                            Validation.passwordValidation(value!),
                        isSufix: true,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginErrorState) {
                            IconSnackBar.show(
                                direction: DismissDirection.up,
                                context: context,
                                snackBarType: SnackBarType.fail,
                                label: '${state.message} !!');
                          } else if (state is LoginFailedState) {
                            IconSnackBar.show(
                                direction: DismissDirection.up,
                                context: context,
                                snackBarType: SnackBarType.fail,
                                label: 'Login Failed !!');
                          } else if (state is LoginSuccessState) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const ScreenParant()),
                                (route) => false);
                            IconSnackBar.show(
                                direction: DismissDirection.up,
                                context: context,
                                snackBarType: SnackBarType.save,
                                label: 'Login Success !!');
                          }
                        },
                        child: ButtonWidget(
                          title: 'Login',
                          onPress: () => loginUser(context),
                        ),
                      ),
                      const SizedBox(height: 50),
                      const SizedBox(height: 50),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen())),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginUser(BuildContext context) {
    Map<String, String> loginData = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };
    context.read<LoginBloc>().add(LoginButtonEvent(loginData: loginData));
  }
}
