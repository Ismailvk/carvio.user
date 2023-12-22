import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:user_side/blocs/signup_bloc/signup_bloc.dart';
import 'package:user_side/resources/components/button_widget.dart';
import 'package:user_side/resources/components/textformfield.dart';
import 'package:user_side/resources/constants/app_color.dart';
import 'package:user_side/utils/validation.dart';
import 'package:user_side/views/login_screen/login_screen.dart';
import 'package:user_side/views/signup_screen/otp_screen.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwrdController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/images/carback2.jpeg"),
                  fit: BoxFit.cover)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: signupKey,
                  child: Column(
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
                          color: AppColors.primaryColor,
                          Icons.person,
                          size: 35,
                        )),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Create an account",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Sign up to join",
                        style: TextStyle(
                          color: AppColors.darkGreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        isSufix: false,
                        validator: (value) => Validation.isEmpty(value, 'Name'),
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        isSufix: false,
                        validator: (value) => Validation.isEmail(value!),
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        isSufix: false,
                        validator: (value) =>
                            Validation.isNumber(value!, 'Mobile Number'),
                        controller: phoneController,
                        hintText: 'Mobile Number',
                        obscureText: false,
                        number: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        isSufix: true,
                        validator: (password) =>
                            Validation.isPassword(password!),
                        controller: passwrdController,
                        hintText: 'Password',
                        obscureText: false,
                      ),
                      const SizedBox(height: 12),
                      MyTextField(
                        isSufix: true,
                        validator: (confirmPassword) =>
                            Validation.isPasswordMatch(
                                confirmPassword, passwrdController.text),
                        controller: confirmController,
                        hintText: 'Conform Password',
                        obscureText: false,
                      ),
                      const SizedBox(height: 40),
                      BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state is SignupSuccessState) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignupOtpScreen(
                                  email: emailController.text,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SignupLoadingState) {
                            return Center(
                              child: LoadingAnimationWidget.inkDrop(
                                  color: AppColors.primaryColor, size: 50),
                            );
                          }
                          return ButtonWidget(
                              title: 'Sign Up', onPress: () => signup(context));
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account?',
                            style: TextStyle(color: AppColors.black),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen())),
                            child: const Text(
                              'Sign In',
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

  signup(BuildContext context) {
    if (signupKey.currentState!.validate()) {
      final phone = int.parse(phoneController.text);
      final userData = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwrdController.text,
        'confirmPass': confirmController.text,
        'phone': phone,
      };
      context
          .read<SignupBloc>()
          .add(SignupButtonClickEvent(userData: userData));
    }
  }
}
